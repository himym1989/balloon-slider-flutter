import 'package:flutter/material.dart';

import 'slider.dart';

class BaloonSlider extends StatefulWidget {
  const BaloonSlider({
    Key? key,
    required this.sliderValue,
    this.color = Colors.black,
    this.baloonWidth = 50,
    this.thumbSize = 12,
    this.thumbColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
  }) : super(key: key);

  final double baloonWidth;
  final double thumbSize;
  final Color? thumbColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color color;
  final ValueNotifier<double> sliderValue;

  @override
  State<BaloonSlider> createState() => _BaloonSliderState();
}

class _BaloonSliderState extends State<BaloonSlider>
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
        activeTrackColor: widget.activeTrackColor ?? widget.color,
        inactiveTrackColor: widget.inactiveTrackColor ?? widget.color,
        thumbColor: widget.thumbColor ?? widget.color,
        thumbSize: widget.thumbSize,
        baloonWidth: widget.baloonWidth,
        value: widget.sliderValue.value,
        onChanged: (value) => widget.sliderValue.value = value,
        animationController: animationController,
      ),
    );
  }
}
