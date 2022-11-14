import 'package:balloon_slider/balloon_slider.dart';
import 'package:flutter/material.dart';

class ExampleSlider extends StatelessWidget {
  ExampleSlider({Key? key}) : super(key: key);
  final ValueNotifier<double> sliderValue = ValueNotifier<double>(0.0);
  static const double balloonPrice = 2.5;
  static const Color basicColor = Colors.deepPurpleAccent;
  static const textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _Title(
          textColor: textColor,
          color: basicColor,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TopSeller(),
            const SizedBox(height: 20),
            const Text(
              'AULE  Party Balloons',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('from $balloonPrice \$'),
                const SizedBox(width: 10),
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'latex balloons',
                  style: TextStyle(color: Colors.black26),
                ),
              ],
            ),
            const SizedBox(height: 70),
            ValueListenableBuilder(
              builder: (BuildContext context, double value, Widget? child) {
                return Text(
                  'Quantity: ${(value * 100).toInt()}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
              valueListenable: sliderValue,
            ),
            const SizedBox(height: 110),
            BalloonSlider(
              balloonTextStyle: const TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              value: sliderValue,
              color: basicColor,
            ),
            const SizedBox(height: 50),
            const _Delivery(),
            const SizedBox(height: 25),
            _Total(
              sliderValue: sliderValue,
              baloonPrice: balloonPrice,
            ),
            const SizedBox(height: 50),
            const _Submit(
              buttonColor: basicColor,
              textColor: textColor,
            )
          ],
        ),
      ),
    );
  }
}

class _Submit extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;

  const _Submit({
    Key? key,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: buttonColor,
        ),
        child: Text(
          'Add to cart',
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

class _Total extends StatelessWidget {
  final double baloonPrice;

  const _Total({
    Key? key,
    required this.baloonPrice,
    required this.sliderValue,
  }) : super(key: key);

  final ValueNotifier<double> sliderValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Total:',
            style: TextStyle(color: Colors.black26),
          ),
        ),
        ValueListenableBuilder(
          builder: (BuildContext context, double value, Widget? child) {
            return Text(
              '${(value * 100).toInt() * baloonPrice}\$',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            );
          },
          valueListenable: sliderValue,
        ),
      ],
    );
  }
}

class _Delivery extends StatelessWidget {
  const _Delivery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFF7F7F7),
          ),
          child: const Icon(
            Icons.delivery_dining_outlined,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 15),
        const Expanded(
          child: Text('Delivery:'),
        ),
        const Text(
          '\$0.0',
          style: TextStyle(color: Colors.black26),
        )
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final Color color;
  final Color textColor;

  const _Title({
    required this.color,
    required this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(width: 30),
        const Icon(
          Icons.person_outline_rounded,
          color: Colors.black,
        ),
        const SizedBox(width: 30),
        Container(
          alignment: Alignment.center,
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: color,
          ),
          child: Text(
            '0',
            style: TextStyle(color: textColor),
          ),
        )
      ],
    );
  }
}

class _TopSeller extends StatelessWidget {
  const _TopSeller({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 55,
          height: 55,
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Image(image: AssetImage('assets/lightning.png')),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        const Text(
          'Top seller',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black26,
          ),
        )
      ],
    );
  }
}
