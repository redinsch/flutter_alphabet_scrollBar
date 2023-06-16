import 'package:alphabet_scrollbar/alphabet_scrollbar.dart';
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
  bool _reversed = false;
  bool _switchToHorizontal = false;
  bool leftSidedOrTop = false;
  bool _leftSidedOrTop = false;
  double _factor = 30;
  double _additional = 15;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 400,
                height: 300,
                child: Column(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                        _letter,
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.normal),
                      ),]
                    ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Switch(value: _reversed, onChanged: (value) => setState(() {
                              _reversed = value;
                            })),
                            const Text(': reversed')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Switch(value: _switchToHorizontal, onChanged: (value) => setState(() {
                              _switchToHorizontal = value;
                            })),
                            const Text(': Switch to Horizontal'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Switch(value: _leftSidedOrTop, onChanged:(value) => setState(() {
                              _leftSidedOrTop = value;
                            }),),
                            const Text(': LeftSidedOrTop')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Slider(max: 300, value: _factor, onChanged:(value) => setState(() {
                              _factor = value.floorToDouble();
                            }),
                            ),
                            Text(': Factor (${_factor.floor()})')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Slider(max: 300, value: _additional, onChanged: (value) => setState(() {
                              _additional = value.floorToDouble();
                            })),
                            Text(': SelectedAdditionalSpace (${_additional.floor()})')
                          ],
                        )
                      ],
                    ),
              ),
            ),
              
              // Thats how Simple it is to get the AlphabetScroll Working..
              //    but you have to handle the Scrolling by yourself
              //    and hide the Original Scrollbar..
              // Padding(
              //   padding: const EdgeInsets.only(right: 15),
              //   child:
              Positioned(
                height: !_switchToHorizontal ? 
                  MediaQuery.of(context).size.height
                  : null,
                width: _switchToHorizontal ? 
                  MediaQuery.of(context).size.width
                  : null,
                right: !_switchToHorizontal && !_leftSidedOrTop ? 0 : null,
                bottom: _switchToHorizontal && !_leftSidedOrTop ? 0 : null,
                left: !_switchToHorizontal && _leftSidedOrTop ? 0 : null,
                top: _switchToHorizontal && _leftSidedOrTop ? 0 : null,
                child: AlphabetScrollbar(
                    onLetterChange: (value) => setState(() {
                      _letter = value;
                    }),
                    reverse: _reversed,
                    switchToHorizontal: _switchToHorizontal,
                    leftSidedOrTop: _leftSidedOrTop,
                    factor: _factor,
                    selectedLetterAdditionalSpace: _additional,
                    padding: EdgeInsets.only(right: 800),
                  ),
                ),
            ],
          ),
      ),
    );
  }
}
