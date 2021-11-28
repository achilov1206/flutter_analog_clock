import 'dart:math';
import 'dart:ui';
import 'package:analog_clock/analog_clock_style.dart';
import 'package:flutter/material.dart';

class AnalogClockPainter extends CustomPainter {
  final TextPainter _hourTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  final DateTime _dateTime;
  final ClockStyle _clockStyle;

  AnalogClockPainter(this._dateTime, this._clockStyle);

  void drawOuterCircle(canvas, Offset center, double radius) {
    Paint _mainCirclePaint = Paint()
      ..color = _clockStyle.outerCircleColor!
      ..style = _clockStyle.outerCirclePaintingStyle
      ..strokeWidth = _clockStyle.outerCircleStrokeWidth!.toDouble();
    canvas.drawCircle(center, radius, _mainCirclePaint);
  }

  void drawCenterDot(canvas, Offset center) {
    Paint _centerDotPaint = Paint()
      ..color = _clockStyle.centerDotColor!
      ..style = _clockStyle.centerDotPaintingStyle
      ..strokeWidth = _clockStyle.centerDotStrokeWidth!.toDouble();
    canvas.drawCircle(
        center, _clockStyle.centerDotRadius!.toDouble(), _centerDotPaint);
  }

  void drawSecondHand(canvas, double centerX, double centerY, double length) {
    Offset _center = Offset(centerX, centerY);
    double _angle = _dateTime.second - 15.0;
    double _secondHandX = centerX + length * cos(_angle * 6 * pi / 180);
    double _secondHandY = centerX + length * sin(_angle * 6 * pi / 180);

    Paint secondHandPaint = Paint()
      ..color = _clockStyle.secondHandColor!
      ..strokeWidth = _clockStyle.secondHandStrokeWidth!.toDouble();
    canvas.drawLine(
        _center, Offset(_secondHandX, _secondHandY), secondHandPaint);
  }

  void drawMinuteHand(canvas, double centerX, double centerY, double length) {
    Offset _center = Offset(centerX, centerY);
    double _angle = _dateTime.minute - 15.0;
    double _secondHandX = centerX + length * cos(_angle * 6 * pi / 180);
    double _secondHandY = centerX + length * sin(_angle * 6 * pi / 180);

    Paint _secondHandPaint = Paint()
      ..color = _clockStyle.minuteHandColor!
      ..strokeWidth = _clockStyle.minuteHandStrokeWidth!.toDouble();
    canvas.drawLine(
        _center, Offset(_secondHandX, _secondHandY), _secondHandPaint);
  }

  void drawHourHand(canvas, double centerX, double centerY, double length) {
    Offset _center = Offset(centerX, centerY);
    double _angle = _dateTime.hour % 12 + _dateTime.minute / 60.0 - 3;
    double _houreHandX = centerX + length * cos((_angle * 30) * pi / 180);
    double _houreHandY = centerX + length * sin((_angle * 30) * pi / 180);

    Paint _houreHandPaint = Paint()
      ..color = _clockStyle.hourHandColor!
      ..strokeWidth = _clockStyle.hourHandStrokeWidth!.toDouble();
    canvas.drawLine(_center, Offset(_houreHandX, _houreHandY), _houreHandPaint);
  }

  void hourTextPaint(Canvas canvas, double radius, double fontSize) {
    double maxTextHeight = 0;
    for (var i = 0; i < 12; i++) {
      double _angle = i * 30.0;
      canvas.save();
      double hourNumberX = cos(_angle * pi / 180) * radius;
      double hourNumberY = sin(_angle * pi / 180) * radius;
      canvas.translate(hourNumberX, hourNumberY);
      int intHour = i + 3;
      if (intHour > 12) intHour = intHour - 12;

      String hourText = _clockStyle.hourNumbers![intHour - 1];
      _hourTextPainter.text = TextSpan(
        text: hourText,
        style: TextStyle(
          fontSize: fontSize,
          color: _clockStyle.hourNumberColor,
        ),
      );
      _hourTextPainter.layout();
      if (_hourTextPainter.height > maxTextHeight) {
        maxTextHeight = _hourTextPainter.height;
      }
      _hourTextPainter.paint(canvas,
          Offset(-_hourTextPainter.width / 2, -_hourTextPainter.height / 2));
      canvas.restore();
    }
  }

  void drawLineTicks(canvas, double radius, double centerX, double centerY) {
    double outerCircleRadius, innerCircleRadius;

    for (double i = 0; i < 360; i += 6) {
      if (i % 5 == 0) {
        innerCircleRadius = radius - 6;
        outerCircleRadius = radius + 8;
      } else {
        innerCircleRadius = radius - 4;
        outerCircleRadius = radius + 4;
      }
      double x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      double y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      double x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      double y2 = centerX + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
  }

  void drawDotTicks(
    canvas,
    double radius,
    double centerX,
    double centerY,
  ) {
    List<Offset> bigTicks = [];
    List<Offset> smallTicks = [];

    for (double i = 0; i < 360; i += 6) {
      double x = centerX + cos(i * pi / 180) * radius;
      double y = centerY + sin(i * pi / 180) * radius;
      if (i % 5 == 0) {
        bigTicks.add(Offset(x, y));
      } else {
        smallTicks.add(Offset(x, y));
      }
    }
    Paint smallTickPaint = Paint()
      ..color = _clockStyle.smallTickColor!
      ..strokeWidth = _clockStyle.smallTickSize!.toDouble()
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, smallTicks, smallTickPaint);

    Paint bigTickPaint = Paint()
      ..color = _clockStyle.bigTickColor!
      ..strokeWidth = _clockStyle.bigTickSize!.toDouble()
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, bigTicks, bigTickPaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    double centerX = 0;
    double centerY = 0;
    Offset center = Offset(centerX, centerY);
    double radius = min(size.width, size.height) / 2;

    if (_clockStyle.showOuterCircle == true) {
      drawOuterCircle(canvas, center, radius);
    }

    if (_clockStyle.showLineTicks == true){
      drawLineTicks(canvas, radius, centerX, centerY);
    }

    if(_clockStyle.showDotTicks == true){
      drawDotTicks(canvas, radius, centerX, centerY);
    }

    if (_clockStyle.showNumbers == true) {
      double _numberRadius = radius - (_clockStyle.hourNumberSize! / 2 + 10);
      hourTextPaint(canvas, _numberRadius, _clockStyle.hourNumberSize!);
    }

    //Second Hand
    if (_clockStyle.showSecondHand == true) {
      int? _length = _clockStyle.secondHandLength ?? (radius - 25).toInt();
      drawSecondHand(canvas, centerX, centerY, _length.toDouble());
    }

    //Minute Hand
    if (_clockStyle.showMinuteHand == true) {
      int? _length = _clockStyle.minuteHandLength ?? (radius - 35).toInt();
      drawMinuteHand(canvas, centerX, centerY, _length.toDouble());
    }
    //Houre Hand
    if (_clockStyle.shoWHourHand == true) {
      int? _length = _clockStyle.minuteHandLength ?? (radius - 50).toInt();
      drawHourHand(canvas, centerX, centerY, _length.toDouble());
    }

    if (_clockStyle.showcenterDot == true) {
      drawCenterDot(canvas, center);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
