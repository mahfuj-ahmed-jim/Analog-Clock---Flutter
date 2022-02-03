import 'package:analog_clock/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'component.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'Dhaka, Bangladesh',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Time(),
            const Spacer(),
            const Clock(),
            const Spacer(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  CountryCard(
                    country: 'Dhaka, Bangladesh',
                    timeZone: '+6 HRS | EST',
                    iconSrc: 'assets/icons/Liberty.svg',
                    time: '09:20',
                    period: 'AM',
                  ),
                  CountryCard(
                    country: 'Dhaka, Bangladesh',
                    timeZone: '+6 HRS | EST',
                    iconSrc: 'assets/icons/Liberty.svg',
                    time: '09:20',
                    period: 'AM',
                  ),
                  CountryCard(
                    country: 'Dhaka, Bangladesh',
                    timeZone: '+6 HRS | EST',
                    iconSrc: 'assets/icons/Liberty.svg',
                    time: '09:20',
                    period: 'AM',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
