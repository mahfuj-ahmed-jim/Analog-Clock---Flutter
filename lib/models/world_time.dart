import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class WorldTime {
  late String location;
  late TimeOfDay timeOfDay;
  late String urlEndPoint;
  late String offset;

  WorldTime({required this.location, required this.urlEndPoint});

  Future<void> getTime() async {
    try {
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$urlEndPoint'));

      Map data = jsonDecode(response.body);

      // get properties
      String dateTime = data['datetime'];
      offset = data['utc_offset'];

      String _offSet = offset.substring(1, 3);

      // convert to dateTime
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(_offSet)));

      timeOfDay = TimeOfDay.fromDateTime(now);
      // ignore: empty_catches
    } catch (e) {}
  }
}
