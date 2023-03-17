import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? time;

  String? flag;
  late String url;
  bool? isDaytime;

  WorldTime({
    this.flag,
    this.location,
    this.isDaytime,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      //get props from data

      String datetime = data['datetime'];
      var offset = data['utc_offset'];

      dynamic offsetParts = offset.split(':');
      int hours = int.parse(offsetParts[0]);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(
        Duration(
          hours: hours,
        ),
      );

//set time property

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      debugPrint('$e');
      time = 'could not get time';
    }
  }
}
