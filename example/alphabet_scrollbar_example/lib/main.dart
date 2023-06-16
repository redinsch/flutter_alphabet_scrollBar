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
  double _padding = 8;
  int _red = Colors.red.red;
  int _green = Colors.red.green;
  int _blue = Colors.red.blue;
 

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
                height: 600,
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
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Slider(max: 100, value: _padding, onChanged:(value) => setState(() {
                            _padding = value.floorToDouble();
                          }),),
                          Text(': Padding as only oneSide (${_padding.floor()})')
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Slider(max: 255, value: _red.toDouble(), onChanged: (value) => setState(() {
                                      _red = value.floor();
                                    })),
                                    Text(": Red ($_red)")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Slider(max: 255, value: _green.toDouble(), onChanged: (value) => setState(() {
                                      _green = value.floor();
                                    })),
                                    Text(": Green ($_green)")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Slider(max: 255, value: _blue.toDouble(), onChanged: (value) => setState(() {
                                      _blue = value.floor();
                                    })),
                                    Text(": Blue ($_blue)")
                                  ],
                                ),
                              ],
                            ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(height: 120,width: 90, color: Color.fromRGBO(_red, _green, _blue,1),),
                                )
                          ],
                        ),
                      const Text("And More... (i.e. Text Style, Duration, ...)", style: TextStyle(fontWeight: FontWeight.bold),)
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
                child: 
                //_________________ALPHABET_SCROLLBAR_______________________________________
                AlphabetScrollbar(
                    onLetterChange: (value) => setState(() {
                      _letter = value;
                    }),
                    reverse: _reversed,
                    switchToHorizontal: _switchToHorizontal,
                    leftSidedOrTop: _leftSidedOrTop,
                    factor: _factor,
                    selectedLetterAdditionalSpace: _additional,
                    padding: EdgeInsets.only(
                      right: !_switchToHorizontal &&!_leftSidedOrTop ? _padding : 0.0, 
                      left: !_switchToHorizontal && _leftSidedOrTop ? _padding : 0.0,
                      top: _switchToHorizontal && _leftSidedOrTop ? _padding : 0.0,
                      bottom: _switchToHorizontal && !_leftSidedOrTop ? _padding : 0.0),
                    selectedLetterColor: Color.fromRGBO(_red, _green, _blue, 1),
                  ),
                  //___________________________________________________________________________
                ),
            ],
          ),
      ),
    );
  }
}
