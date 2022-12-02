import 'package:flutter/material.dart';
import 'package:world_cup/models/error_model.dart';
import 'package:world_cup/models/local_match.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/services/matches_service.dart';
import 'package:world_cup/utility/snackbar.dart';

class MatchProvider with ChangeNotifier {
  List<Match> _matches = [];
  List<Match> get matches => [..._matches];

  List<Match> _allMatches = [];
  List<Match> get allMatches => [..._allMatches];

  List<LocalMatch> _matchesTime = [];
  List<LocalMatch> get matchTimes => [..._matchesTime];

  bool _matchesInit = false;
  bool get matchesInit => _matchesInit;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> fetchMatches(BuildContext context,
      {DateTime? time, bool updateListenrs = true}) async {
    _loading = true;
    if (updateListenrs) notifyListeners();
    _matches = [];
    try {
      _matches = await MatchServices.instance.fetchMatches(time);
    } on ErrorModel catch (e) {
      _matches = [];
      showAppSnackBar(context, e.errorMessage);
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> saveLocalMatches() async {
    try {
      _allMatches = matches;
      _matchesTime = [];
      for (var i = 0; i < _allMatches.length; i++) {
        if (!_allMatches[i].hasStarted) {
          LocalMatch matchTime = LocalMatch.fromMatch(_allMatches[i]);
          _matchesTime.add(matchTime);
        }
      }
      _matchesTime = matchTimes;
      _matchesInit = true;
    } on ErrorModel catch (e) {
      _allMatches = [];
      _matchesInit = false;
    }
  }
}
