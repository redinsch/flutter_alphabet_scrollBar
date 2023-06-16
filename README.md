<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

The AlphabetScrollBar Package is an Simple to use, Customizable Animated AlphabetScrollBar.
You have to offer an Function where you do the Scrolling by yourself.
There must be an String Parameter, where you will receive the Current Selected Letter.


## Features

it`s Possible to Change almost Everything.. the Letters that are Used, the Text-Style of the Letters, the Color of the Selected Letter, the Orientation of the Scrollbar (Left, Right, Top, Bottom, Reversed)




#### <a href="https://redinsch.github.io/flutter_alphabet_scrollBar/">Click here for a simple Live-preview</a>

<video controls="true">
  <source src="./example.mov" type="video/mov">
  <source src="https://github.com/redinsch/flutter_alphabet_scrollBar/assets/1113928/e0599a76-ac3b-4221-b9af-fe0c6590e35a">
</video>

## Getting started

```yaml
alphabet_scrollbar: ^0.0.5
```

```dart
AlphabetScrollbar(
    //onLetterChange is needed and should contain a Function(String letter), where you handle your Scrolling. 
                  onLetterChange: (value) => setState(() {
                    _letter = value;
                  }),
                  reverse: false, //optional. would Reverse the Order (Z-A).
                  switchToHorizontal: false, //optional. makes the Scrollbar Horizontally not Verticaly.
                  
                  //optional. changes the side to left (if switchToHorizontal also True,Switches to Top)
                  leftSidedOrTop: false, 
                ),
```
## Usage

u can Simply Use this Widget. all of these Parameters (except the onLetterChange) are Optional.

AllParamsExample:
```dart
AlphabetScrollbar(
                  onLetterChange: (value) => setState(() {
                    _letter = value;
                  }),
                  style: const TextStyle(),
                  duration: const Duration(),
                  selectedLetterAdditionalSpace: 15.toDouble(),
                  selectedLetterColor: Colors.red,
                  padding: EdgeInsets.all(8),
                  factor: 30,
                  letterCollection: const ["A","B","C"],
                  reverse: false,
                  switchToHorizontal: false,
                  leftSidedOrTop: false,
                );
```

Minimal Params Example:
```dart
AlphabetScrollbar(
                  onLetterChange: (value) => setState(() {
                    _letter = value;
                  }),
                );
```

for Scrolling you have to do something like this... (Just an Example)
```dart
void _onLetterChangeExample(String letter){
    var index = _myList.indexWhere((n) =>
            n.toLowerCase().startsWith(letter.toLowerCase()));
    _scrollController.scrollTo(_itemHeight * index);
}
```

