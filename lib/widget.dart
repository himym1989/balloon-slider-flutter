import 'package:flutter/material.dart';

import 'slider.dart';

class BalloonSlider extends StatefulWidget {
  const BalloonSlider({
    Key? key,
    required this.value,
    this.color = Colors.black,
    this.balloonWidth = 50,
    this.thumbSize = 12,
    this.thumbColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.balloonTextStyle,
  }) : super(key: key);

  final double balloonWidth;
  final double thumbSize;
  final Color? thumbColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color color;
  final TextStyle? balloonTextStyle;
  final ValueNotifier<double> value;

  @override
  State<BalloonSlider> createState() => _BalloonSliderState();
}

class _BalloonSliderState extends State<BalloonSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double value;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SliderRender(
        balloonTextStyle: widget.balloonTextStyle,
        activeTrackColor: widget.activeTrackColor ?? widget.color,
        inactiveTrackColor: widget.inactiveTrackColor ?? widget.color,
        thumbColor: widget.thumbColor ?? widget.color,
        thumbSize: widget.thumbSize,
        balloonWidth: widget.balloonWidth,
        value: widget.value.value,
        onChanged: (value) => widget.value.value = value,
        animationController: animationController,
      ),
    );
  }
}
