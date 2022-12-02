import 'package:flutter/material.dart';
import 'package:world_cup/models/player_predictions.dart';
import 'package:world_cup/styles/input_value_text.dart';
import 'package:world_cup/utility/data_transform.dart';

class PredictionItem extends StatelessWidget {
  final PlayerPredictions predictions;
  final bool isMe;
  const PredictionItem(
      {super.key, required this.predictions, this.isMe = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${predictions.homeTeam!.nameCode} Vs ${predictions.awayTeam!.nameCode}',
                      style: titleText,
                    ),
                    Text(
                      getShortDate(
                        localDate(predictions.startTime!),
                      ),
                      style: titleText,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(isMe
                        ? 'You predicted        : '
                        : 'Predicted                : '),
                    Text(
                      predictions.predictText,
                      style: inputValueText,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Match conclusion : '),
                    Text(
                      predictions.matchConclusion,
                      style: inputValueText,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Awarded points     : '),
                    Text(
                      predictions.userPredict!.awardedPoints == null
                          ? 'Pending..'
                          : predictions.userPredict!.awardedPoints.toString(),
                      style: inputValueText,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Divider(
              height: 5,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
