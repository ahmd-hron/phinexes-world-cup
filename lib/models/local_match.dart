import 'dart:convert';

import 'package:world_cup/models/match.dart';
import 'package:world_cup/utility/data_transform.dart';

class LocalMatch {
  int? id;
  DateTime? date;
  String? matchName;
  bool? userPredicted;

  LocalMatch({this.date, this.id, this.matchName, this.userPredicted});

  String toShared() {
    Map<String, dynamic> matchTime = {
      'id': id,
      'date': date == null ? null : localDate(date!).toIso8601String(),
      'matchName': matchName,
      'userPredicted': userPredicted
    };
    return json.encode(matchTime);
  }

  LocalMatch.fromShared(String jsonData) {
    Map<String, dynamic> matchTime = json.decode(jsonData);
    id = matchTime['id'];
    date = DateTime.tryParse(matchTime['date']);
    matchName = matchTime['date'];
    userPredicted = matchTime['userPredicted'];
  }

  LocalMatch.fromMatch(Match match) {
    id = match.id;
    date = localDate(match.startTime!);
    matchName = match.name;
    userPredicted = match.hasPredicted;
  }

  //notifications will be shown based on minutes number
  // if minute is 30 notification will be shown before 30 min of the game
  Duration getTimeDifference(DateTime date, int minutes) {
    DateTime notifictionTime = DateTime(
      date.year,
      date.month,
      date.day,
      date.hour - 1,
      date.minute + minutes,
    );
    return notifictionTime.difference(DateTime.now());
  }
}
