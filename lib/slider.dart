import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'balloon_painter.dart';

class SliderRender extends SingleChildRenderObjectWidget {
  final Color inactiveTrackColor;
  final Color activeTrackColor;
  final Color thumbColor;
  final double thumbSize;
  final double baloonWidth;
  final double value;
  final AnimationController animationController;
  final ValueChanged<double> onChanged;

  const SliderRender({
    required this.animationController,
    required this.inactiveTrackColor,
    required this.activeTrackColor,
    required this.thumbColor,
    required this.thumbSize,
    required this.baloonWidth,
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(context) {
    return SliderRenderBox(
      baloonWidth: baloonWidth,
      inactiveTrackColor: inactiveTrackColor,
      activeTrackColor: activeTrackColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize,
      value: value,
      animationController: animationController,
      onChanged: onChanged,
    );
  }

  @override
  void updateRenderObject(context, covariant SliderRenderBox renderObject) {
    super.updateRenderObject(
      context,
      renderObject
        ..updateWith(
          thumbSize: thumbSize,
          thumbColor: thumbColor,
          activeTrackColor: activeTrackColor,
          inactiveTrackColor: inactiveTrackColor,
        ),
    );
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

class SliderRenderBox extends RenderBox {
  SliderRenderBox({
    required Color inactiveTrackColor,
    required Color activeTrackColor,
    required Color thumbColor,
    required double thumbSize,
    required double baloonWidth,
    required double value,
    required this.animationController,
    required this.onChanged,
  })  : _inactiveTrackColor = inactiveTrackColor,
        _activeTrackColor = activeTrackColor,
        _thumbColor = thumbColor,
        _thumbSize = thumbSize,
        _currentThumbValue = value,
        _baloonWidth = baloonWidth {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = (DragStartDetails details) {
        moving = true;
        _updateThumbPosition(details.localPosition);
        onChanged(_currentThumbValue);
      }
      ..onUpdate = (DragUpdateDetails details) {
        onChanged(_currentThumbValue);

        _currentThumbValue = details.localPosition.dx;
        _updateThumbPosition(details.localPosition);
      }
      ..onEnd = (details) {
        moving = false;
        markNeedsPaint();
      };
  }

  final AnimationController animationController;
  final ValueChanged<double> onChanged;
  final Debouncer _endTimer = Debouncer(milliseconds: 1000);
  late HorizontalDragGestureRecognizer _drag;

  bool moving = false;
  double _currentThumbValue;
  double? initOffset;
  double _baloonWidth;
  double _balloonScale = 0.0;
  Color _inactiveTrackColor;
  Color _activeTrackColor;
  Color _thumbColor;
  double _thumbSize;

  void updateWith({
    double? baloonWidth,
    double? thumbSize,
    Color? thumbColor,
    Color? inactiveTrackColor,
    Color? activeTrackColor,
  }) {
    _inactiveTrackColor = inactiveTrackColor ?? _inactiveTrackColor;
    _activeTrackColor = activeTrackColor ?? _activeTrackColor;
    _thumbColor = thumbColor ?? _thumbColor;
    _thumbSize = thumbSize ?? _thumbSize;
    _baloonWidth = baloonWidth ?? _baloonWidth;
    markNeedsPaint();
  }

  // set constraints for render box
  @override
  void performLayout() {
    size = constraints.constrain(
      Size(constraints.maxWidth, _thumbSize),
    );
  }

  @override
  void detach() {
    _drag.dispose();
    animationController.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void attach(covariant PipelineOwner owner) {
    animationController.addListener(markNeedsPaint);
    super.attach(owner);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double trackHeight = 2;
    double baloonHeight = _baloonWidth * 1.2987012987012987;

    final canvas = context.canvas;
    canvas.save();

    // drawing tracks
    Rect inactiveTrackRect = Rect.fromLTWH(
      offset.dx + _thumbSize,
      offset.dy + (size.height - trackHeight) / 2,
      size.width - _thumbSize * 2,
      trackHeight,
    );

    Rect activeTrackRect = Rect.fromLTWH(
      offset.dx + _thumbSize,
      offset.dy + (size.height - trackHeight) / 2,
      (size.width - _thumbSize * 2) * _currentThumbValue,
      trackHeight,
    );

    final inactiveTrackPaint = Paint()..color = Colors.black.withOpacity(0.2);
    final activeTrackPaint = Paint()..color = _thumbColor;

    canvas.drawRRect(RRect.fromRectAndRadius(inactiveTrackRect, Radius.zero),
        inactiveTrackPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(activeTrackRect, Radius.zero),
        activeTrackPaint);

    // setting thumb rect and painting thumb
    Rect thumbRect = Rect.fromCircle(
      center: Offset(
        inactiveTrackRect.left + _currentThumbValue * inactiveTrackRect.width,
        inactiveTrackRect.center.dy,
      ),
      radius: _thumbSize,
    );

    Rect innerThumbRect = Rect.fromCircle(
      center: Offset(
        inactiveTrackRect.left + _currentThumbValue * inactiveTrackRect.width,
        inactiveTrackRect.center.dy,
      ),
      radius: _thumbSize / 3 + _thumbSize / 2 * _balloonScale,
    );

    final thumbPaint = Paint()
      ..color = _thumbColor
      ..style = PaintingStyle.fill;
    final innerThumbPaint = Paint()..color = Colors.white;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          thumbRect,
          Radius.circular(_thumbSize),
        ),
        thumbPaint);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          innerThumbRect,
          Radius.circular(_thumbSize),
        ),
        innerThumbPaint);

    initOffset ??= thumbRect.center.dx;

    Rect balloonRect = Rect.fromLTWH(
      initOffset! - _baloonWidth / 2,
      offset.dy - baloonHeight / 2 - baloonHeight - 5,
      _baloonWidth,
      baloonHeight,
    );

    final targetOffset = thumbRect.center.dx;
    double diff = thumbRect.center.dx - balloonRect.center.dx;

    var balloonXOffset = initOffset! + diff / 10.0;

    if (diff > 0) {
      balloonXOffset = min(balloonXOffset, targetOffset);
    } else {
      balloonXOffset = max(balloonXOffset, targetOffset);
    }

    double balloonYOffset =
        thumbRect.bottomCenter.dy - balloonRect.topCenter.dy;
    double angle = balloonYOffset != 0 ? -atan(diff / balloonYOffset) : 0;
    initOffset = balloonXOffset;

    canvas.translate(
      balloonRect.center.dx,
      balloonRect.center.dy + 50,
    );
    canvas.rotate(angle);

    if (moving) {
      _balloonScale = (_balloonScale + 0.05).clamp(0.0, 1.0);
    } else {
      _balloonScale = (_balloonScale - 0.06).clamp(0.0, 1.0);
    }

    canvas.scale(_balloonScale, _balloonScale);
    canvas.translate(0, _balloonScale * -50);

    BalloonPainter(
      color: _thumbColor,
      value: _currentThumbValue,
    ).paint(canvas, balloonRect.size);

    canvas.restore();
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
    moving = true;
    markNeedsPaint();
    markNeedsSemanticsUpdate();

    _endTimer.run(() {
      markNeedsPaint();
      animationController.repeat();
    });
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
