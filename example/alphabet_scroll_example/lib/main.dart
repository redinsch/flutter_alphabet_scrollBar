import 'dart:html';

import 'package:alphabet_scroll/alphabet_scroll.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<StatefulWidget> createState() => _StateMainApp();
}

class _StateMainApp extends State<MainApp> {
  _StateMainApp();

  var _letter = "The Selected Letter should Show up Here..";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Text(
                _letter,
                style: const TextStyle(
                    fontSize: 40, fontWeight: FontWeight.normal),
              ),
            ),
            // Thats how Simple it is to get the AlphabetScroll Working..
            //    but you have to handle the Scrolling by yourself
            //    and hide the Original Scrollbar..
            // Padding(
            //   padding: const EdgeInsets.only(right: 15),
            //   child:
            Positioned.fill(
              //right: 8,
              child: AlphabetScrollbar(
                onLetterChange: (value) => setState(() {
                  _letter = value;
                }),
                reverse: false,
                switchToHorizontal: false,
                leftSidedOrTop: true,
              ),
            ),
            // )
          ],
        ),
      ),
    );
  }
}
