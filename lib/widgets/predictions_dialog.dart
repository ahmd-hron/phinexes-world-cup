import 'package:flutter/material.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/pages/match%20page/components/predection_list.dart';
import 'package:world_cup/utility/size_config.dart';

class PredictionDialog extends StatelessWidget {
  final Match match;
  const PredictionDialog({super.key, required this.match});

  double get height {
    double totalHeight = 0;
    if (match.predictions == null) {
      totalHeight = 8;
    } else {
      if (totalHeight < 40) totalHeight += match.predictions!.length * 10;
    }
    return getPercentScreenHeight(totalHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Team Predictions')),
      content: SizedBox(
        height: height,
        width: getPercentScreenWidth(80),
        child: Column(
          children: [
            Expanded(
              child: PredectionList(match: match),
            ),
            Text(match.score)
          ],
        ),
      ),
    );
  }
}
