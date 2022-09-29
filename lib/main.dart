import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var card_aspect_ratio = 12.0 / 16.0;
var widget_aspect_ratio = card_aspect_ratio * 1.2;

class _MyHomePageState extends State<MyHomePage> {
  var currentPage = titles.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: titles.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
    return Scaffold(
        backgroundColor: Color(0xFF2d3447),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 30.0, bottom: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {})
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Trending",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          size: 28.0,
                          color: Colors.white,
                        ))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFff6e6e),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 6.0),
                        child: Text(
                          "Animated",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    "25+ Stories",
                    style: TextStyle(color: Colors.blueAccent),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                CardScrollWidget(currentPage),
                Positioned.fill(
                    child: PageView.builder(
                  itemCount: titles.length,
                  reverse: true,
                  controller: controller,
                  itemBuilder: (context, index) {
                    return Container();
                  },
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 6.0),
                        child: Text("Latest",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text("9+ Stories", style: TextStyle(color: Colors.blueAccent))
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:
                  Image.asset("assets/img1.jpg", width: 296.0, height: 222.0),
            )
          ],
        )));
  }
}

class CardScrollWidget extends StatelessWidget {
  double? currentPage;
  var paddings = 20.0;
  var verticalInset = 20.0;
  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget_aspect_ratio,
      child: LayoutBuilder(builder: (context, constraints) {
        var height = constraints.maxHeight;
        var width = constraints.maxWidth;
        var safeWidth = width - 2 * paddings;
        var safeHeight = height - 2 * paddings;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * card_aspect_ratio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horiontalInset = primaryCardLeft / 2;

        List<Widget> cardList = [];

        for (var i = 0; i < titles.length; i++) {
          var delta = i - currentPage!;
          bool isOnRight = delta > 0;

          var start = paddings +
              max(
                  primaryCardLeft -
                      horiontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: paddings + verticalInset * max(-delta, 0.0),
            bottom: paddings + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: Container(
                decoration: BoxDecoration(),
                child: AspectRatio(
                  aspectRatio: card_aspect_ratio,
                  child: Stack(fit: StackFit.expand, children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        "assets/img1.jpg",
                        fit: BoxFit.cover,
                      ),
                    )
                  ]),
                )),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
