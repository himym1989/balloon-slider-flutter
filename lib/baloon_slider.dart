import 'package:baloon_slider_2/slider_track.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MySlider extends StatelessWidget {
  const MySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baloon Slider'),
        backgroundColor: const Color.fromARGB(255, 255, 206, 89),
      ),
      body: const BaloonSlider(),
    );
  }
}

class BaloonSlider extends StatefulWidget {
  const BaloonSlider({Key? key}) : super(key: key);

  @override
  State<BaloonSlider> createState() => _BaloonSliderState();
}

class _BaloonSliderState extends State<BaloonSlider>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 10,
            child: SliderTrack(
              activeTrackColor: const Color.fromARGB(255, 255, 206, 89),
              inactiveTrackColor: Colors.black,
              thumbColor: const Color.fromARGB(255, 255, 206, 89),
              thumbSize: 15,
              baloonWidth: 50,
            ),
          )
        ],
      ),
    );
  }
}

// class SliderPainter extends CustomPainter {
//   Offset dragPosition;
//   Color foregroundColor;

//   SliderPainter({
//     required this.foregroundColor,
//     required this.dragPosition,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     double outerThumbRadius = 10;
//     double innerThumbRadius = 7;

//     Paint backgroundPaint = Paint()
//       ..color = Colors.black.withOpacity(0.2)
//       ..strokeWidth = 1
//       ..style = PaintingStyle.stroke;

//     Paint foregroundPaint = Paint()
//       ..color = foregroundColor
//       ..strokeWidth = 2;

//     Paint outerThumbPaint = Paint()
//       ..color = foregroundColor
//       ..style = PaintingStyle.fill;

//     Paint innerThumbPaint = Paint()..color = Colors.white;

//     canvas.drawLine(
//       Offset(0, size.height / 2),
//       Offset(size.width, size.height / 2),
//       backgroundPaint,
//     );
//     canvas.drawLine(
//       Offset(0, size.height / 2),
//       Offset(dragPosition.dx, size.height / 2),
//       foregroundPaint,
//     );

//     canvas.drawCircle(
//       Offset(dragPosition.dx + outerThumbRadius / 2, size.height / 2),
//       outerThumbRadius,
//       outerThumbPaint,
//     );
//     canvas.drawCircle(
//       Offset(dragPosition.dx + outerThumbRadius / 2, size.height / 2),
//       innerThumbRadius,
//       innerThumbPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
