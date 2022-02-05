import 'package:analog_clock/component/component.dart';
import 'package:analog_clock/models/cities.dart';
import 'package:flutter/material.dart';

class OtherCityTimes extends StatelessWidget {
  const OtherCityTimes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Cities> cities = [
      Cities(name: 'London, UK', endPoint: 'Europe/London'),
      Cities(name: 'Dhaka, Bangladesh', endPoint: 'Asia/Dhaka'),
      Cities(name: 'Berlin, Germany', endPoint: 'Europe/Berlin'),
      Cities(name: 'Cairo, Egypt', endPoint: 'Africa/Cairo'),
      /*Cities(name: 'Dhaka, Bangladesh', endPoint: 'Asia/Dhaka'),
    Cities(name: 'Dhaka, Bangladesh', endPoint: 'Asia/Dhaka'),
    Cities(name: 'Dhaka, Bangladesh', endPoint: 'Asia/Dhaka'),
    Cities(name: 'Dhaka, Bangladesh', endPoint: 'Asia/Dhaka'),
    Cities(name: 'Dhaka, Bangladesh', endPoint: 'Asia/Dhaka'),*/
    ];
    return Container(
      height: 160,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: cities.length,
          itemBuilder: (context, index) {
            return CountryCard(
              city: cities[index],
            );
          }),
    );
  }
}
