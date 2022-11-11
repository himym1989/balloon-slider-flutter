import 'package:balloon_slider/balloon_slider.dart';
import 'package:flutter/material.dart';

class ExampleSlider extends StatelessWidget {
  ExampleSlider({Key? key}) : super(key: key);
  final ValueNotifier<double> sliderValue = ValueNotifier<double>(0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baloon Slider'),
        backgroundColor: const Color.fromARGB(255, 255, 206, 89),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              builder: (BuildContext context, double value, Widget? child) {
                return Text(
                  'Quantity: ${(value * 100).toInt()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
              valueListenable: sliderValue,
            ),
            const SizedBox(height: 120),
            BaloonSlider(
              sliderValue: sliderValue,
              color: const Color.fromARGB(255, 255, 206, 89),
            ),
          ],
        ),
      ),
    );
  }
}
