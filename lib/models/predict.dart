class Predictions {
  int? id;
  int? playerId;
  int? matchId;
  int? homeScorePredict;
  int? awayScorePredict;
  int? homeScorePredictot;
  int? awayscorePredictot;
  int? awardedPoints;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? firstName;
  String? lastName;

  Predictions(
      {this.awardedPoints,
      this.awayScorePredict,
      this.awayscorePredictot,
      this.createdAt,
      this.homeScorePredict,
      this.homeScorePredictot,
      this.id,
      this.matchId,
      this.playerId,
      this.updatedAt,
      this.firstName,
      this.lastName});

  Predictions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['player_id'];
    matchId = json['match_id'];
    homeScorePredict = json['home_score_predict'];
    awayScorePredict = json['away_score_predict'];
    homeScorePredictot = json['home_score_predict_ot'];
    awayscorePredictot = json['away_score_predict_ot'];
    awardedPoints = json['awarded_points'];

    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  String? get name {
    return '$firstName  $lastName';
  }

  String predictText(String? homeTeam, String? awayTeam) {
    return ' $homeTeam $homeScorePredict -  $awayScorePredict $awayTeam';
  }

  String get playerNameShort {
    String firstChar = firstName!.substring(0, 1);
    String lastChar = lastName!.substring(0, 1);
    return firstChar + lastChar;
  }

  @override
  toString() {
    return '''
   id $id
   playerId $playerId
   matchId $matchId
   homeScorePredict  $homeScorePredict
   awayScorePredict  $awayScorePredict
   homeScorePredictot  $homeScorePredictot
  ''';
  }
}
