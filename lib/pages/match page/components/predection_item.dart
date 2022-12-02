import 'dart:math';
import 'package:flutter/material.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/models/predict.dart';
import 'package:world_cup/utility/data_transform.dart';
import 'package:world_cup/utility/size_config.dart';

class PredectionItem extends StatelessWidget {
  final Match match;
  final Predictions predict;
  const PredectionItem({
    super.key,
    required this.predict,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.symmetric(horizontal: getPercentScreenWidth(5)),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tooltip(
                message: '${predict.firstName} ${predict.lastName}',
                child: CircleAvatar(
                  foregroundColor: Colors.white,
                  backgroundColor: randomColor,
                  child: Text(
                    predict.playerNameShort,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                predict.predictText(
                    match.homeTeam!.nameCode, match.awayTeam!.nameCode),
              ),
              Text(
                predict.awardedPoints == null
                    ? 'Pending..'
                    : predict.awardedPoints.toString(),
              ),
            ],
          )),
      const Divider()
    ]);
  }
}
