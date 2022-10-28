import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliderTrack extends LeafRenderObjectWidget {
  Color inactiveTrackColor;
  Color activeTrackColor;
  Color thumbColor;
  double thumbSize;
  double baloonWidth;

  SliderTrack({
    required this.inactiveTrackColor,
    required this.activeTrackColor,
    required this.thumbColor,
    required this.thumbSize,
    required this.baloonWidth,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliderTrack(
      baloonWidth: baloonWidth,
      inactiveTrackColor: inactiveTrackColor,
      activeTrackColor: activeTrackColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderSliderTrack renderObject) {
    renderObject
      ..inactiveTrackColor = inactiveTrackColor
      ..activeTrackColor = activeTrackColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize;
// super.updateRenderObject(context, renderObject);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('inactiveTrackColor', inactiveTrackColor));
    properties.add(ColorProperty('activeTrackColor', activeTrackColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
  }
}

class RenderSliderTrack extends RenderBox {
  RenderSliderTrack({
    required Color inactiveTrackColor,
    required Color activeTrackColor,
    required Color thumbColor,
    required double thumbSize,
    required double baloonWidth,
  })  : _inactiveTrackColor = inactiveTrackColor,
        _activeTrackColor = activeTrackColor,
        _thumbColor = thumbColor,
        _thumbSize = thumbSize,
        _baloonWidth = baloonWidth {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = (DragStartDetails details) {
        _updateThumbPosition(details.localPosition);
      }
      ..onUpdate = (DragUpdateDetails details) {
        _updateThumbPosition(details.localPosition);
      }
      ..onEnd = (details) {
        isThumbPushed = false;
        markNeedsPaint();
      };
  }

  late HorizontalDragGestureRecognizer _drag;
  bool isThumbPushed = false;

  double _currentThumbValue = 0.5;

  // color of the inactive track
  Color get inactiveTrackColor => _inactiveTrackColor;
  Color _inactiveTrackColor;
  set inactiveTrackColor(Color color) {
    if (_inactiveTrackColor == color) {
      return;
    }
    _inactiveTrackColor = color;
    markNeedsPaint();
  }

  // color of the active track
  Color get activeTrackColor => _activeTrackColor;
  Color _activeTrackColor;
  set activeTrackColor(Color color) {
    if (_activeTrackColor == color) {
      return;
    }
    _activeTrackColor = color;
    markNeedsPaint();
  }

  // color of the thumb
  Color get thumbColor => _thumbColor;
  Color _thumbColor;
  set thumbColor(Color color) {
    if (_thumbColor == color) {
      return;
    }
    _thumbColor = color;
    markNeedsPaint();
  }

  //size of the thumb
  double get thumbSize => _thumbSize;
  double _thumbSize;
  set thumbSize(double value) {
    if (_thumbSize == value) {
      return;
    }
    _thumbSize = value;
    markNeedsPaint();
  }

  //size of the baloon
  double get baloonWidth => _baloonWidth;
  double _baloonWidth;
  set baloonWidth(double value) {
    if (_baloonWidth == value) {
      return;
    }
    _baloonWidth = value;
    markNeedsPaint();
  }

  // set constraints for render box
  @override
  void performLayout() {
    // super.performLayout();
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbSize;

    final desiredSize = Size(desiredWidth, desiredHeight);
    size = constraints.constrain(desiredSize);
  }

  @override
  void detach() {
    _drag.dispose();
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    // paint inactive track
    final inactiveTrackPaint = Paint()
      ..color = inactiveTrackColor.withOpacity(0.3)
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      inactiveTrackPaint,
    );

    // setup thumb
    final thumbPaint = Paint()..color = thumbColor;
    final thumbDX = _currentThumbValue * size.width;

    final innerThumbPaint = Paint()..color = Colors.white;
    double thumbSizeFinal = isThumbPushed ? thumbSize : thumbSize * 0.7;

    // paint active track
    final activeTrackPaint = Paint()
      ..color = activeTrackColor
      ..strokeWidth = 2;
    final startPoint = Offset(0, size.height / 2);
    final endPoint = Offset(thumbDX, size.height / 2);
    canvas.drawLine(startPoint, endPoint, activeTrackPaint);

    // paint thumb
    final center = Offset(thumbDX, size.height / 2);
    canvas.drawCircle(center, thumbSizeFinal, thumbPaint);
    canvas.drawCircle(center, thumbSizeFinal * 0.7, innerThumbPaint);
    canvas.restore();

    // paint baloon
    double baloonHeight = (baloonWidth * 1.2987012987012987).toDouble();
    Size baloonSize = Size(baloonWidth, baloonHeight);

    double baloonXOffset = thumbDX + baloonWidth / 2 - thumbSize / 2;
    double baloonYOffset = offset.dy - baloonHeight - thumbSize;

    _drawBaloon(canvas, baloonSize, Offset(baloonXOffset, baloonYOffset),
        thumbColor, _currentThumbValue);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag.addPointer(event);
    }
  }

  void _updateThumbPosition(Offset localPosition) {
    var dx = localPosition.dx.clamp(0, size.width);
    _currentThumbValue = dx / size.width;
    isThumbPushed = true;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  void _drawBaloon(
      Canvas canvas, Size size, Offset offset, Color color, double thumbValue) {
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
      ..color = thumbColor;

    // painting current value
    TextPainter value = TextPainter(
        textWidthBasis: TextWidthBasis.parent,
        text: TextSpan(
            text: '${(thumbValue * 100).toInt()}',
            style: const TextStyle(color: Colors.black, fontSize: 18)),
        textDirection: TextDirection.ltr);
    value.layout();

    canvas.translate(offset.dx, offset.dy);
    canvas.drawPath(path_0, p);
    value.paint(
        canvas,
        Offset(size.width / 2 - value.width / 2,
            size.height / 2 - value.height / 2));

    canvas.restore();
  }
}
