library alphabet_scrollbar;

import 'dart:math' as math;

import 'package:flutter/material.dart';

class AlphabetScrollbar extends StatefulWidget {
  const AlphabetScrollbar(
      {super.key,
      this.selectedLetterColor = Colors.red,
      required this.onLetterChange,
      this.style,
      this.padding,
      this.leftSidedOrTop = false,
      this.switchToHorizontal = false,
      this.reverse = false,
      this.factor = 30,
      this.selectedLetterAdditionalSpace = 15,
      this.duration = const Duration(milliseconds: 200),
      this.letterCollection,
      this.halfSinWaveLength = 6});

  final Color selectedLetterColor;
  final Function(String) onLetterChange;
  final TextStyle? style;
  final EdgeInsets? padding;
  final bool leftSidedOrTop;
  final bool switchToHorizontal;
  final bool reverse;
  final double factor;
  final double selectedLetterAdditionalSpace;
  final Duration duration;
  final List<String>? letterCollection;
  final int halfSinWaveLength;

  @override
  State<StatefulWidget> createState() => _AlphabetScrollbarState();
}

class _AlphabetScrollbarState extends State<AlphabetScrollbar> {
  _AlphabetScrollbarState();

  final GlobalKey _alphabetContainerKey = GlobalKey();
  int _alphabetIndex = 0;
  bool _alphabetScrollActive = false;
  List<String> _alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  double dy = 0.0;
  double itemSize = 0.0;

  @override
  void initState() {
    super.initState();
    _alphabet = widget.letterCollection ?? _alphabet;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior
          .opaque, // => This dissables Hit-Detection of elements behind..
      //Vertically
      onVerticalDragStart: widget.switchToHorizontal
          ? null
          : (details) => {
                _alphabetScrollActive = true,
                _onDragUpdate(dy: details.localPosition.dy)
              },
      onVerticalDragEnd: widget.switchToHorizontal
          ? null
          : (details) => {
                setState(() {
                  _alphabetScrollActive = false;
                  _alphabetIndex = 0;
                })
              },
      onVerticalDragUpdate: widget.switchToHorizontal
          ? null
          : (DragUpdateDetails dragUpdateDetails) =>
              _onDragUpdate(dy: dragUpdateDetails.localPosition.dy),
      //Horizontaly
      onHorizontalDragStart: !widget.switchToHorizontal
          ? null
          : (details) => {
                _alphabetScrollActive = true,
                _onDragUpdate(dx: details.localPosition.dx)
              },
      onHorizontalDragEnd: !widget.switchToHorizontal
          ? null
          : (details) => {
                setState(() {
                  _alphabetScrollActive = false;
                  _alphabetIndex = 0;
                })
              },
      onHorizontalDragUpdate: !widget.switchToHorizontal
          ? null
          : (DragUpdateDetails dragUpdateDetails) =>
              _onDragUpdate(dx: dragUpdateDetails.localPosition.dx),
      child: Padding(padding: widget.padding ?? const EdgeInsets.all(0) ,child: widget.switchToHorizontal
          ? Row(
              key: _alphabetContainerKey,
              crossAxisAlignment: widget.leftSidedOrTop
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getAlphabetScroll())
          : Column(
              key: _alphabetContainerKey,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: widget.leftSidedOrTop
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: _getAlphabetScroll(),
            ),)
    );
  }

  List<Widget> _getAlphabetScroll() {
    List<Widget> alphabetScroll = [];

    var alphabetValues =
        widget.reverse ? _alphabet.reversed.toList() : _alphabet;

    for (var letter in alphabetValues) {
      var indexOfLetter = alphabetValues.indexOf(letter);
      num space = 0;
      TextStyle? selectedLetterStyle = widget.style;
      if (_alphabetScrollActive &&
          indexOfLetter >= _alphabetIndex - widget.halfSinWaveLength &&
          indexOfLetter <= _alphabetIndex + widget.halfSinWaveLength) {

        var relativeIndex =
            ((_alphabetIndex - widget.halfSinWaveLength) * (-1)) +
                indexOfLetter;

        var deg = relativeIndex - ((dy / itemSize) - _alphabetIndex);
        var rad = deg * (widget.halfSinWaveLength * 2 + 3) / 180 * math.pi;

        space = math.sin(rad);
        if (space < 0) space = 0;
        space = space * widget.factor;
        if (indexOfLetter == _alphabetIndex) {
          space = space + widget.selectedLetterAdditionalSpace;
          selectedLetterStyle = selectedLetterStyle?.copyWith(
                  color: widget.selectedLetterColor) ??
              TextStyle(color: widget.selectedLetterColor);
        }
      }
      alphabetScroll.add(AnimatedContainer(
        duration: widget.duration,
        padding: widget.switchToHorizontal && widget.leftSidedOrTop
            ? EdgeInsets.only(top: space.toDouble())
            : widget.switchToHorizontal
                ? EdgeInsets.only(bottom: space.toDouble())
                : widget.leftSidedOrTop
                    ? EdgeInsets.only(left: space.toDouble())
                    : EdgeInsets.only(right: space.toDouble()),
        child: Text(
          style: selectedLetterStyle,
          letter,
          textAlign: TextAlign.center,
        ),
      ));
    }

    return alphabetScroll;
  }

  // function to get current Selected alphabet
  int _getAlphabetIndexFromDy({double? dy, double? dx}) {
    if (widget.switchToHorizontal && dx == null) {
      throw Exception("AlphabetScroll was Horizontaly but got no dx!");
    } else if (!widget.switchToHorizontal && dy == null) {
      throw Exception("AlphabetScroll was Verticaly but got no dy!");
    }

    final alphabetContainer =
        _alphabetContainerKey.currentContext?.findRenderObject() as RenderBox;
    final alphabetContainerSize = widget.switchToHorizontal
        ? alphabetContainer.size.width
        : alphabetContainer.size.height;
    final oneItemSize = alphabetContainerSize / _alphabet.length;
    itemSize = oneItemSize;
    final index = widget.switchToHorizontal
        ? (dx! / oneItemSize).floor()
        : (dy! / oneItemSize).floor();
    if (index < 0) {
      return 0;
    } else if (index > _alphabet.length) {
      return _alphabet.length;
    }
    return index;
  }

  String _getLetterByAlphabetID(int alphabetID) {
    var alphabetValues =
        widget.reverse ? _alphabet.reversed.toList() : _alphabet;

    return alphabetValues.singleWhere(
        (element) => alphabetValues.indexOf(element) == alphabetID);
  }

  void _onDragUpdate({double? dy, double? dx}) {
    var alphabetIndex = _getAlphabetIndexFromDy(dy: dy, dx: dx);

    setState(() {
      _alphabetIndex = alphabetIndex;
      this.dy = dy ?? dx!;
    });

    widget.onLetterChange(_getLetterByAlphabetID(alphabetIndex));
  }
}
