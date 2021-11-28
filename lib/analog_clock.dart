import 'dart:async';
import 'package:analog_clock/analog_clock_painter.dart';
import 'package:analog_clock/analog_clock_style.dart';
import 'package:flutter/material.dart';

class AnalogClock extends StatefulWidget {
  final double? width;
  final double? height;
  final DateTime? dateTime;
  final ClockStyle? clockStyle;
  final bool? isLive;

  const AnalogClock(
      {this.width,
      this.height,
      this.dateTime,
      this.clockStyle,
      this.isLive,
      Key? key})
      : super(key: key);

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  Timer? _timer;
  DateTime? _dateTime;


  @override
  void initState() {

    _dateTime ??= widget.dateTime;

    _timer = widget.isLive!
        ? Timer.periodic(const Duration(seconds: 1), (timer) {
            _dateTime = _dateTime!.add(const Duration(seconds: 1));
            if(mounted){
              setState(() {});
            }
          })
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter:
            AnalogClockPainter(_dateTime!, widget.clockStyle!),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
