import 'package:flutter/material.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/pages/match%20page/components/edite_prediction.dart';
import 'package:world_cup/utility/size_config.dart';

class PredictCard extends StatefulWidget {
  final Match match;
  const PredictCard({super.key, required this.match});

  @override
  State<PredictCard> createState() => _PredictCardState();
}

class _PredictCardState extends State<PredictCard> {
  bool editeMode = false;

  @override
  Widget build(BuildContext context) {
    editeMode = widget.match.editeMode;
    return SizedBox(
      width: getPercentScreenWidth(90),
      height: getPercentScreenHeight(editeMode ? 18 : 8),
      child: editeMode
          ? EditePredict(
              match: widget.match,
            )
          : getPredictWidget,
    );
  }

  Widget get getPredictWidget {
    switch (widget.match.getMatchStatus) {
      case MatchPredictStatus.predictable:
        return Card(
          color: Colors.white.withOpacity(0.08),
          elevation: 4,
          margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Center(
            child: TextButton(
              onPressed: widget.match.edite,
              child: Text(
                'Predict now!',
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      case MatchPredictStatus.editible:
        return Card(
          color: Colors.white.withOpacity(0.08),
          elevation: 4,
          margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Your Prid:'),
                Text(
                  widget.match.myPredict!.predictText(
                      widget.match.homeTeam!.nameCode,
                      widget.match.awayTeam!.nameCode),
                ),
                IconButton(
                  onPressed: widget.match.edite,
                  icon: const Icon(Icons.edit),
                )
              ],
            ),
          )),
        );
      case MatchPredictStatus.unEdditable:
        return Card(
          color: Colors.white.withOpacity(0.08),
          elevation: 4,
          margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Your Prid:'),
                Text(
                  widget.match.myPredict!.predictText(
                      widget.match.homeTeam!.nameCode,
                      widget.match.awayTeam!.nameCode),
                ),

                Text('P : ${widget.match.myPredict!.awardedPoints ?? '...'}'),
                // IconButton(onPressed: switchToEditeMode, icon: const Icon(Icons.edit),)
              ],
            ),
          )),
        );
      case MatchPredictStatus.unPredictable:
        return Card(
          color: Colors.white.withOpacity(0.08),
          elevation: 4,
          margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: const Center(child: Text('You missed this one :(')),
        );
    }
  }
}
