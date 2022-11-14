import 'package:flutter/material.dart';

class BalloonPainter extends CustomPainter {
  const BalloonPainter({
    required this.color,
    this.value = 0,
    this.textStyle,
  });

  final Color color;
  final TextStyle? textStyle;
  final double value;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(-size.width / 2, -size.height / 2);
    size = Size(size.width, size.height);
    Path path_0 = Path();

    path_0.moveTo(size.width * 0.4534416, size.height * 0.8897600);
    path_0.cubicTo(
        size.width * 0.4498312,
        size.height * 0.8874400,
        size.width * 0.4433896,
        size.height * 0.8832800,
        size.width * 0.4341299,
        size.height * 0.8770200);
    path_0.cubicTo(
        size.width * 0.4168961,
        size.height * 0.8653670,
        size.width * 0.3998948,
        size.height * 0.8535120,
        size.width * 0.3831299,
        size.height * 0.8414600);
    path_0.cubicTo(
        size.width * 0.3304545,
        size.height * 0.8036000,
        size.width * 0.2777143,
        size.height * 0.7623300,
        size.width * 0.2284545,
        size.height * 0.7190000);
    path_0.cubicTo(
        size.width * 0.1501818,
        size.height * 0.6502400,
        size.width * 0.08819481,
        size.height * 0.5828700,
        size.width * 0.04832468,
        size.height * 0.5191500);
    path_0.cubicTo(size.width * 0.01688312, size.height * 0.4687100, 0,
        size.height * 0.4214600, 0, size.height * 0.3780000);
    path_0.cubicTo(0, size.height * 0.1592900, size.width * 0.2139610, 0,
        size.width * 0.4954805, 0);
    path_0.cubicTo(
        size.width * 0.7770000,
        0,
        size.width * 0.9909091,
        size.height * 0.1592900,
        size.width * 0.9909091,
        size.height * 0.3780000);
    path_0.cubicTo(
        size.width * 0.9909091,
        size.height * 0.4213900,
        size.width * 0.9741299,
        size.height * 0.4685300,
        size.width * 0.9427792,
        size.height * 0.5189200);
    path_0.cubicTo(
        size.width * 0.9030130,
        size.height * 0.5827400,
        size.width * 0.8409091,
        size.height * 0.6501600,
        size.width * 0.7625844,
        size.height * 0.7189700);
    path_0.cubicTo(
        size.width * 0.7133896,
        size.height * 0.7622500,
        size.width * 0.6607143,
        size.height * 0.8034800,
        size.width * 0.6080390,
        size.height * 0.8413600);
    path_0.cubicTo(
        size.width * 0.5912831,
        size.height * 0.8534030,
        size.width * 0.5742818,
        size.height * 0.8652410,
        size.width * 0.5570390,
        size.height * 0.8768700);
    path_0.cubicTo(
        size.width * 0.5477532,
        size.height * 0.8831000,
        size.width * 0.5410649,
        size.height * 0.8875200,
        size.width * 0.5379221,
        size.height * 0.8895300);
    path_0.cubicTo(
        size.width * 0.5260481,
        size.height * 0.8970850,
        size.width * 0.5111390,
        size.height * 0.9012380,
        size.width * 0.4957351,
        size.height * 0.9012800);
    path_0.cubicTo(
        size.width * 0.4803312,
        size.height * 0.9013220,
        size.width * 0.4653844,
        size.height * 0.8972510,
        size.width * 0.4534416,
        size.height * 0.8897600);
    path_0.close();
    path_0.moveTo(size.width * 0.4531039, size.height * 0.9204300);
    path_0.cubicTo(
        size.width * 0.4585740,
        size.height * 0.9160080,
        size.width * 0.4651532,
        size.height * 0.9124880,
        size.width * 0.4724442,
        size.height * 0.9100830);
    path_0.cubicTo(
        size.width * 0.4797338,
        size.height * 0.9076770,
        size.width * 0.4875818,
        size.height * 0.9064370,
        size.width * 0.4955130,
        size.height * 0.9064370);
    path_0.cubicTo(
        size.width * 0.5034442,
        size.height * 0.9064370,
        size.width * 0.5112922,
        size.height * 0.9076770,
        size.width * 0.5185818,
        size.height * 0.9100830);
    path_0.cubicTo(
        size.width * 0.5258727,
        size.height * 0.9124880,
        size.width * 0.5324519,
        size.height * 0.9160080,
        size.width * 0.5379221,
        size.height * 0.9204300);
    path_0.lineTo(size.width * 0.5742857, size.height * 0.9503300);
    path_0.cubicTo(
        size.width * 0.6012208,
        size.height * 0.9724600,
        size.width * 0.5828442,
        size.height,
        size.width * 0.5405195,
        size.height);
    path_0.lineTo(size.width * 0.4504286, size.height);
    path_0.cubicTo(
        size.width * 0.4083247,
        size.height,
        size.width * 0.3897403,
        size.height * 0.9725200,
        size.width * 0.4166623,
        size.height * 0.9503300);
    path_0.lineTo(size.width * 0.4531039, size.height * 0.9204300);
    path_0.close();

    Paint p = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    // painting current value
    TextPainter value = TextPainter(
      textWidthBasis: TextWidthBasis.parent,
      text: TextSpan(
        text: '${(this.value * 100).toInt()}',
        style: textStyle ?? const TextStyle(
          color: Colors.black26,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    value.layout();

    canvas.drawPath(path_0, p);

    value.paint(
      canvas,
      Offset(
        size.width / 2 - value.width / 2,
        size.height / 2 - value.height / 2,
      ),
    );
  }
}
