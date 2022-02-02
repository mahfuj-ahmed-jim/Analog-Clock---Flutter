import 'package:flutter/material.dart';
import 'component.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Dhaka, Bangladesh',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Time(),
          Clock(),
        ],
      ),
    );
  }
}
