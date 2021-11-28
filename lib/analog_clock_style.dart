import 'package:flutter/material.dart';

enum CustomPaintingStyle {
  stroke,
  fill,
}

class ClockStyle {
  bool? showOuterCircle = false;
  Color? outerCircleColor;
  int? _outerCirclePaintingStyle = 0;
  int? outerCircleStrokeWidth = 3;
  get outerCirclePaintingStyle => _outerCirclePaintingStyle == 0
      ? PaintingStyle.stroke
      : PaintingStyle.fill;
  set outerCirclePaintingStyle(dynamic val) => _outerCirclePaintingStyle = val;

  bool? showcenterDot = true;
  Color? centerDotColor;
  int? _centerDotPaintingStyle;
  int? centerDotStrokeWidth = 3;
  int? centerDotRadius = 4;
  get centerDotPaintingStyle =>
      _centerDotPaintingStyle == 0 ? PaintingStyle.stroke : PaintingStyle.fill;
  set centerDotPaintingStyle(dynamic val) =>
      _centerDotPaintingStyle == null ? 0 : val;

  bool? showSecondHand = true;
  Color? secondHandColor;
  int? secondHandStrokeWidth = 2;
  int? secondHandLength;

  bool? showMinuteHand = true;
  Color? minuteHandColor;
  int? minuteHandStrokeWidth = 3;
  int? minuteHandLength;

  bool? shoWHourHand = true;
  Color? hourHandColor;
  int? hourHandStrokeWidth = 4;
  int? hourHandLength;

  bool? showNumbers = true;
  List<String>? hourNumbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  Color? hourNumberColor = Colors.black;
  double? hourNumberSize = 30;

  bool? showLineTicks = false;
  bool? showDotTicks = true;
  Color? smallTickColor = Colors.black;
  Color? bigTickColor = Colors.black;
  int? smallTickSize = 5;
  int? bigTickSize = 10;

  ClockStyle(
      {this.showOuterCircle,
      this.outerCircleColor,
      this.outerCircleStrokeWidth,
      outerCirclePaintingStyle,
      this.showcenterDot,
      this.centerDotColor,
      this.centerDotStrokeWidth,
      this.centerDotRadius,
      centerDotPaintingStyle,
      this.showSecondHand,
      this.secondHandColor,
      this.secondHandStrokeWidth,
      this.secondHandLength,
      this.showMinuteHand,
      this.minuteHandColor,
      this.minuteHandStrokeWidth,
      this.minuteHandLength,
      this.shoWHourHand,
      this.hourHandColor,
      this.hourHandStrokeWidth,
      this.hourHandLength,
      this.hourNumbers,
      this.hourNumberColor,
      this.hourNumberSize,
      this.showLineTicks,
      this.showDotTicks,
      this.smallTickColor,
      this.bigTickColor,
      this.smallTickSize,
      this.bigTickSize,
      });

  ClockStyle.defaultStyle() {
    outerCircleColor = Colors.black;
    centerDotColor = Colors.black;
    secondHandColor = Colors.red;
    minuteHandColor = Colors.black;
    hourHandColor = Colors.black;
  }
}
