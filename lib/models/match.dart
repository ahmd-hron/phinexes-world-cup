import 'package:flutter/cupertino.dart';
import 'package:world_cup/models/predict.dart';
import 'package:world_cup/models/team.dart';
import 'package:world_cup/providers/notifications_provider.dart';
import 'package:world_cup/services/predict_service.dart';
import 'package:world_cup/utility/data_transform.dart';

enum MatchPredictStatus {
  predictable,
  editible,
  unPredictable,
  unEdditable,
}

class Match with ChangeNotifier {
  int? id;
  String? roundName;
  int? status;
  // 0 not started ,
  // 1 first team won
  // 2 second team won
  // 3 draw
  int? winnerCode;
  DateTime? startTime;
  Team? homeTeam;
  Team? awayTeam;
  Predictions? myPredict;
  List<Predictions>? predictions;
  bool editeMode = false;
  Map<String, dynamic>? statistic;
  Map<String, dynamic>? statisticRe;

  Match({
    this.id,
    this.awayTeam,
    this.homeTeam,
    this.roundName,
    this.status,
    this.myPredict,
    this.predictions,
    this.startTime,
    this.winnerCode,
    this.statistic,
  });

  Match.fromJson(json) {
    id = json['id'];
    roundName = json['round_name'];
    status = json['status'];
    winnerCode = json['winner_code'];
    homeTeam = Team.fromJson(json['home_team']);
    awayTeam = Team.fromJson(json['away_team']);
    startTime = DateTime.tryParse(json['started_at']);
    if (json['my_predict'] != null) {
      myPredict = Predictions.fromJson(json['my_predict']);
    }
    List<dynamic> jsonPrecstions = json['predictions'];
    predictions = jsonPrecstions.map((e) => Predictions.fromJson(e)).toList();
    if (json['statistics_scores'] != null &&
        json['statistics_scores'].isNotEmpty) {
      statistic = Map<String, dynamic>.from(json['statistics_scores']);
    }
    if (json['statistics_results'] != null &&
        json['statistics_results'].isNotEmpty) {
      statisticRe = Map<String, dynamic>.from(json['statistics_results']);
    }
  }
  bool get hasStarted {
    return !localDate(startTime!).isAfter(DateTime.now());
  }

  bool get hasPredicted {
    return myPredict != null;
  }

  MatchPredictStatus get getMatchStatus {
    if (!hasPredicted && !hasStarted) {
      return MatchPredictStatus.predictable;
    } else if (hasPredicted && !hasStarted) {
      return MatchPredictStatus.editible;
    } else if (!hasPredicted && hasStarted) {
      return MatchPredictStatus.unPredictable;
    } else if (hasPredicted && hasStarted) {
      return MatchPredictStatus.unEdditable;
    } else {
      //this case will never happen
      return MatchPredictStatus.predictable;
    }
  }

  switchToEDiteMode(bool value) {
    editeMode = value;
  }

  cancel() {
    editeMode = false;
    notifyListeners();
  }

  edite() {
    editeMode = true;
    notifyListeners();
  }

  Future<bool> sendPrediction(int home, int away) async {
    try {
      final response =
          await PredictService.instance.sendPredict(id!, home, away);
      myPredict = response!;
      editeMode = false;
      // NotificationHelper.instance.cancel(id);
      notifyListeners();
    } catch (e) {
      // print(object)
      return false;
    }
    return true;
  }

  @override
  String toString() {
    return '''
   id: $id,
   away team:$awayTeam,
   home team $homeTeam,
   round name $roundName,
   status $status,
   mypredict $myPredict,
   start time $startTime,
   winnercode $winnerCode,

''';
  }

  String get name {
    return '${homeTeam!.nameCode} vs ${awayTeam!.nameCode}';
  }

  String get score {
    if (!hasStarted) return '${homeTeam!.nameCode} vs ${awayTeam!.nameCode}';
    if (hasStarted && homeTeam!.score == null) {
      return '${homeTeam!.nameCode}   vs   ${awayTeam!.nameCode}';
    }
    return '${homeTeam!.nameCode} ${homeTeam!.score} - ${awayTeam!.score} ${awayTeam!.nameCode}';
  }

  String? matchStaticsReText(String value) {
    if (value == 'win_count') return homeTeam?.nameCode;
    if (value == 'lose_count') return awayTeam?.nameCode;
    return 'Draw';
  }

  Color? matchStaticsReColor(String value) {
    if (value == 'win_count') return homeTeam?.primaryColor;
    if (value == 'lose_count') {
      return awayTeam?.primaryColor == homeTeam?.primaryColor!
          ? awayTeam?.secondaryColor
          : awayTeam?.primaryColor;
    }
    return randomColor;
  }

  int get statisticLength {
    if (statistic == null) return 0;
    int total = 0;
    dynamic list = statistic!.values.toList();
    for (var i = 0; i < list.length; i++) {
      total += (list[i] as int);
    }
    return total;
  }
}
