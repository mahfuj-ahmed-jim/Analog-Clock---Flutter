import 'dart:async';

import 'package:analog_clock/models/cities.dart';
import 'package:analog_clock/models/world_time.dart';
import 'package:analog_clock/size_config.dart';
import 'package:analog_clock/static/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryCard extends StatefulWidget {
  final Cities city;

  const CountryCard({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  State<CountryCard> createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  late String timeZone = 'Waiting', time = 'waiting', period = 'waiting';
  late TimeOfDay timeOfDay;
  late WorldTime worldTime;
  late DateTime dateTime = DateTime.now();

  void changeTime() {
    setState(() {
      String hour = timeOfDay.hour <= 12
          ? timeOfDay.hour >= 10
              ? '${timeOfDay.hour}'
              : '0${timeOfDay.hour}'
          : timeOfDay.hour % 12 >= 10
              ? '${timeOfDay.hour % 12}'
              : '0${timeOfDay.hour % 12}';
      String minute = timeOfDay.minute >= 10
          ? '${timeOfDay.minute}'
          : '0${timeOfDay.minute}';
      time = '$hour:$minute';

      period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
      timeZone = worldTime.offset;
    });
  }

  Future<void> setTime() async {
    worldTime = WorldTime(location: 'Dhaka', urlEndPoint: widget.city.endPoint);
    await worldTime.getTime();
    timeOfDay = worldTime.timeOfDay;
    changeTime();
  }

  @override
  void initState() {
    super.initState();
    setTime();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (dateTime.minute != DateTime.now().minute) {
        if (timeOfDay.minute >= 59) {
          timeOfDay = TimeOfDay(hour: timeOfDay.hour + 1, minute: 0);
        } else {
          timeOfDay =
              TimeOfDay(hour: timeOfDay.hour, minute: timeOfDay.minute + 1);
        }
        changeTime();
        dateTime = DateTime.now();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: SizedBox(
        width: getProportionateScreenWidth(233),
        child: AspectRatio(
          aspectRatio: 1.32,
          child: InkWell(
            onTap: () {
              StaticTime.name = widget.city.name;
              StaticTime.timeOfDay = timeOfDay;
              DateTime dateTime = DateTime.now();
              StaticTime.dateTime = DateTime(
                  dateTime.year,
                  dateTime.month,
                  dateTime.day,
                  worldTime.timeOfDay.hour,
                  worldTime.timeOfDay.minute);
            },
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (Theme.of(context).primaryIconTheme.color)!,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.city.name,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: getProportionateScreenWidth(16),
                          )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    timeZone,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SvgPicture.asset(
                        //iconSrc,
                        'assets/icons/Liberty.svg',
                        width: getProportionateScreenWidth(40),
                        color: Theme.of(context).accentIconTheme.color,
                      ),
                      const Spacer(),
                      Text(
                        time,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(period),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
