import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:intl/intl.dart';

getShortDate(DateTime date) {
  var format = DateFormat('yyyy-MM-dd').format(date);
  return format;
}

getTime(DateTime date) {
  return DateFormat('HH:mm').format(date).toString().replaceAll("T", "  ");
}

DateTime localDate(DateTime dateTime) {
  var localTime = DateTime.utc(dateTime.year, dateTime.month, dateTime.day,
          dateTime.hour, dateTime.minute)
      .toLocal();
  return localTime;
}

DateTime get today {
  return DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
}

DateTime date(DateTime time) {
  return DateTime(time.year, time.month, time.day);
}

String dateToString(DateTime time) {
  return '${time.year}-${time.month}-${time.day}';
}

Color get randomColor {
  var random = Random();
  return Color.fromRGBO(
      random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
}

Color? colorConvert(String? value, String shortCod) {
  if (value == null) return randomColor;
  int? hex = int.tryParse('0xff${value.substring(1)}');

  return hex == null ? randomColor : Color(hex);
}

String voteCount(dynamic value) {
  if (value == 1) return ' $value vote';
  return ' $value votes';
}
