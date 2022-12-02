import 'package:flutter/animation.dart';
import 'package:world_cup/utility/data_transform.dart';

class Team {
  int? id;
  String? name;
  String? nameCode;
  String? imageUrl;
  String? ranking;
  int? score;
  int? scoreOvertime;
  int? scorePenalties;
  Color? primaryColor;
  Color? secondaryColor;

  Team(
      {this.id,
      this.imageUrl,
      this.name,
      this.nameCode,
      this.ranking,
      this.primaryColor,
      this.secondaryColor,
      this.score});

  Team.fromJson(data) {
    id = data['id'];
    name = data['full_name'];
    nameCode = data['name_code'];
    ranking = data['ranking'];
    imageUrl = data['image_url'];
    score = data['score'];
    scoreOvertime = data['score_overtime'];
    scorePenalties = data['score_penalties'];
    primaryColor =
        colorConvert(data['primary_color'], nameCode!) ?? randomColor;
    secondaryColor =
        colorConvert(data['secondary_color'], nameCode!) ?? randomColor;
  }
}
