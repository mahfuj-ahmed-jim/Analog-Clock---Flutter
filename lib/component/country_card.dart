import 'package:analog_clock/models/cities.dart';
import 'package:analog_clock/models/world_time.dart';
import 'package:analog_clock/size_config.dart';
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
  late WorldTime worldTime;

  Future<void> setTime() async {
    worldTime = WorldTime(location: 'Dhaka', urlEndPoint: widget.city.endPoint);
    await worldTime.getTime();
    setState(() {
      String hour = worldTime.timeOfDay.hour <= 12
          ? worldTime.timeOfDay.hour >= 10
              ? '${worldTime.timeOfDay.hour}'
              : '0${worldTime.timeOfDay.hour}'
          : worldTime.timeOfDay.hour % 12 >= 10
              ? '${worldTime.timeOfDay.hour % 12}'
              : '0${worldTime.timeOfDay.hour % 12}';
      String minute = worldTime.timeOfDay.minute >= 10
          ? '${worldTime.timeOfDay.minute}'
          : '0${worldTime.timeOfDay.minute}';
      time = '$hour:$minute';

      period = worldTime.timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
      timeZone = worldTime.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    setTime();
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
            onTap: () => print(widget.city.name),
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
