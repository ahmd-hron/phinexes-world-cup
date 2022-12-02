import 'package:flutter/material.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/pages/match%20page/match%20details/components/prediction_statistic_list.dart';
import 'package:world_cup/pages/match%20page/match%20details/components/predictions_statics_resoults.dart';
import 'package:world_cup/utility/size_config.dart';

class MatchDetailsBody extends StatelessWidget {
  final Match match;
  const MatchDetailsBody({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        children: [
          SizedBox(
              height: getPercentScreenHeight(45),
              child: PredictionStatisticsList(match: match)),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              width: getPercentScreenWidth(50),
              child: const Divider(thickness: 2)),
          SizedBox(
            height: getPercentScreenHeight(45),
            child: PredictionsStaticsResoults(match: match),
          ),
        ],
      ),
    );
  }
}
