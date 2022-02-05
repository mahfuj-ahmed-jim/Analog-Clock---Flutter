import 'package:flutter/material.dart';
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
            Time(),
            const Spacer(),
            const Clock(),
            const Spacer(),
            const OtherCityTimes(),
          ],
        ),
      ),
    );
  }
}
