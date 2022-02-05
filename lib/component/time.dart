import 'dart:async';
import 'package:analog_clock/size_config.dart';
import 'package:analog_clock/static/time_static.dart';
import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  Time({Key? key}) : super(key: key);

  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  late TimeOfDay time = TimeOfDay.now();
  late String name = 'Dhaka, Bangladesh';

  @override
  void initState() {
    super.initState();
    // constantly update time
    Timer.periodic(const Duration(seconds: 1), (timer) {
      try {
        if (StaticTime.name == name) {
        } else {
          setState(() {
            name = StaticTime.name;
            time = StaticTime.timeOfDay;
          });
        }
      } catch (e) {
        if (time.minute != TimeOfDay.now().minute) {
          setState(() {
            time = TimeOfDay.now();
          });
        }
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
    return Column(
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$hour:$minute',
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
        ),
      ],
    );
  }
}
