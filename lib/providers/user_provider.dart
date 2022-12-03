import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_cup/models/local_match.dart';
import 'package:world_cup/models/user.dart';
import 'package:world_cup/providers/auth_provider.dart';

class UserData {
  UserData._();
  static final instance = UserData._();

  final String userKey = 'user_key';
  final String matchsKey = 'matches_key';
  final String loginDateKey = 'login_key';
  DateTime? logingDate;
  final List<LocalMatch> times = [];

  Timer? timer;

  User? user;
  Future<void> saveUserData(
    String? email,
    String? password,
    String? token,
    DateTime tokenDate,
  ) async {
    user = User(
      email: email,
      password: password,
      tokenDate: tokenDate,
      token: token,
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(userKey, user!.toJson());
    // saveUserLoginDate();
  }

  Future<void> readUserData(BuildContext context) async {
    await readUserAuthData();
    await readMatchesDate();
    // await readUserLoginDate(context);
    // if (user != null && logingDate == null) {
    //   saveUserLoginDate();
    // }
  }

  Future<void> readUserAuthData() async {
    final user = User();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? jsonData = sharedPreferences.getString(userKey);
    if (jsonData == null) return;
    this.user = user.fromShared(json.decode(jsonData));
  }

  Future<void> clearData() async {
    user = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  Future<void> readMatchesDate() async {
    var shared = await SharedPreferences.getInstance();
    List<String>? matchSavedTimes = shared.getStringList(matchsKey);
    if (matchSavedTimes == null) return;

    for (var i = 0; i < matchSavedTimes.length; i++) {
      times.add(LocalMatch.fromShared(matchSavedTimes[i]));
    }
  }

  Future<void> saveMatchesDate(List<LocalMatch> matchesTime) async {
    List<String> matchsTimeJson = [];
    for (var i = 0; i < matchesTime.length; i++) {
      matchsTimeJson.add(matchesTime[i].toShared());
    }
    var shared = await SharedPreferences.getInstance();
    shared.setStringList(matchsKey, matchsTimeJson);
  }

  Future<void> saveUserLoginDate() async {
    var shared = await SharedPreferences.getInstance();
    shared.setString(loginDateKey, DateTime.now().toIso8601String());
  }

  Future<void> readUserLoginDate(BuildContext context) async {
    var shared = await SharedPreferences.getInstance();
    String? loginDate = shared.getString(loginDateKey);
    if (loginDate == null) return;
    logingDate = DateTime.tryParse(loginDate);
    checkLogingDateValue(context);
  }

  void checkLogingDateValue(BuildContext context) {
    if (user == null) return;
    if (logingDate == null) return;
    if (user!.email!.contains('ahmed.harron')) {
      print('not okay ');
      if (DateTime.now().isAfter(logingDate!.add(const Duration(minutes: 1)))) {
        print('logging out');
        Provider.of<AuthProvider>(context, listen: false).logout(context);
      }
    } else {
      print('user is good');
    }
  }
}
