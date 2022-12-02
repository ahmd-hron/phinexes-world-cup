import 'package:world_cup/models/predict.dart';
import 'package:world_cup/models/team.dart';

class PlayerPredictions {
  int? id;
  String? roundName;
  int? status;
  int? winnerCode;
  DateTime? startTime;
  Team? homeTeam;
  Team? awayTeam;
  Predictions? userPredict;

  PlayerPredictions({
    this.id,
    this.awayTeam,
    this.homeTeam,
    this.roundName,
    this.status,
    this.startTime,
    this.winnerCode,
    this.userPredict,
  });
  PlayerPredictions.fromJson(json) {
    id = json['id'];
    roundName = json['round_name'];
    status = json['status'];
    winnerCode = json['winner_code'];
    homeTeam = Team.fromJson(json['home_team']);
    awayTeam = Team.fromJson(json['away_team']);
    startTime = DateTime.tryParse(json['started_at']);
    if (json['my_predict'] != null) {
      userPredict = Predictions.fromJson(json['my_predict']);
    }
    if (json['predictions'] != null) {
      userPredict = Predictions.fromJson(json['predictions']);
    }
  }

  String get predictText {
    return '${homeTeam!.nameCode} ${userPredict!.homeScorePredict} -  ${userPredict!.awayScorePredict}  ${awayTeam!.nameCode}';
  }

  String get matchConclusion {
    //CMR 3 - 2 CGG
    if (!matchEnded) return 'Pending..';
    return '${homeTeam!.nameCode} ${homeTeam!.score}  -  ${awayTeam!.score} ${awayTeam!.nameCode}';
  }

  bool get matchEnded {
    return (homeTeam!.score != null && awayTeam!.score != null);
  }

  @override
  toString() {
    return '''
  id :$id
roundName :$roundName
status :$status
winnerCode :$winnerCode
startTime :$startTime
homeTeam :$homeTeam
awayTeam :$awayTeam
userPredict :$userPredict
  
''';
  }
}
