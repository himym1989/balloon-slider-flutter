# Flutter Balloon Slider

A Flutter plugin to create range slider with balloon animation effect.

Inspired by [Cuberto - Balloon Slider](https://dribbble.com/shots/6549207-Balloon-Slider-Control)

[![Pub package](https://img.shields.io/pub/v/balloon_slider.svg)](https://pub.dartlang.org/packages/balloon_slider)
[![Star on GitHub](https://img.shields.io/github/stars/himym1989/baloon-slider-flutter.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/himym1989/baloon-slider-flutter)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

<img src="./screens/1.gif" width="241"> &nbsp; <img src="./screens/2.gif" width="240">

* Add this to your pubspec.yaml
  ```
  dependencies:
  balloon_slider: ^1.0.0
  ```
* Get the package from Pub:
  ```
  flutter packages get
  ```
* Import it in your file
  ```
  import 'package:balloon_slider/balloon_slider.dart';
  ```

## Usage

``` dart
BalloonSlider(
  balloonTextStyle: const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
  value: sliderValue,
  color: Colors.yellow,
),
```

## Credits

 * [Cuberto - Balloon Slider](https://dribbble.com/shots/6549207-Balloon-Slider-Control)

## Maintainers
 
 * [Olena Zhukova](https://github.com/himym1989)
 
## License

 [![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
