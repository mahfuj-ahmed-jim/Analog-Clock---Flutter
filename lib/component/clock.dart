import 'dart:async';
import 'dart:math';

import 'package:analog_clock/component/component.dart';
import 'package:analog_clock/constants/constants.dart';
import 'package:analog_clock/models/models.dart';
import 'package:analog_clock/size_config.dart';
import 'package:analog_clock/static/time_static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime dateTime = DateTime.now();
  DateTime secondDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // constantly update time
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        dateTime = StaticTime.dateTime;
        secondDateTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  color: kShadowColor.withOpacity(0.14),
                  blurRadius: 64,
                )
              ],
            ),
            child: Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                painter: ClockPainter(
                  context,
                  dateTime,
                  secondDateTime,
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
          top: 50,
          right: 0,
          left: 0,
          child: Consumer<MyThemeModel>(
            builder: (context, theme, child) => GestureDetector(
              onTap: () => theme.changeTheme(),
              child: SvgPicture.asset(
                theme.isLightTheme
                    ? 'assets/icons/Sun.svg'
                    : 'assets/icons/Moon.svg',
                height: 24,
                width: 24,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ))
    ]);
  }
}
