import 'package:flutter/material.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/utility/data_transform.dart';
import 'package:world_cup/utility/size_config.dart';

class PredictionStatisticsList extends StatelessWidget {
  final Match match;
  const PredictionStatisticsList({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    if (match.statistic == null || match.statistic!.keys.isEmpty) {
      return const Center(
        child: Text('No data Available yet'),
      );
    }
    int? itemLength = match.statistic!.keys.length;
    return ListView.builder(
      itemCount: itemLength,
      itemBuilder: (ctx, i) {
        int itemsWidth = match.predictions!.length;
        int itemWidth = match.statistic!.values.toList()[i];
        double widgetLength = 100;
        double cWidth = (itemWidth / itemsWidth) * widgetLength;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            color: Colors.white.withOpacity(0.08),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                    width: 35, child: Text(match.statistic!.keys.toList()[i])),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: getPercentScreenWidth(3),
                    right: getPercentScreenWidth(3)),
                color: randomColor,
                alignment: Alignment.center,
                height: getPercentScreenHeight(6),
                width: getPercentScreenWidth(cWidth - ((40 / 100) * cWidth)),
                child: Text(
                  '${cWidth.round()}%',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  // color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: Text(voteCount(match.statistic!.values.toList()[i])),
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
