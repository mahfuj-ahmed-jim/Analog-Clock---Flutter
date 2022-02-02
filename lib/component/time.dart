import 'dart:async';
import 'package:analog_clock/size_config.dart';
import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  const Time({Key? key}) : super(key: key);

  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  TimeOfDay time = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    // constantly update time
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time.minute != TimeOfDay.now().minute) {
        setState(() {
          time = TimeOfDay.now();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    String hour = time.hour <= 12
        ? time.hour >= 10
            ? '${time.hour}'
            : '0${time.hour}'
        : time.hour % 12 >= 10
            ? '${time.hour % 12}'
            : '0${time.hour % 12}';
    String minute = time.minute >= 10 ? '${time.minute}' : '0${time.minute}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$hour : $minute',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(
          width: 5,
        ),
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            period,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
            ),
          ),
        )
      ],
    );
  }
}
