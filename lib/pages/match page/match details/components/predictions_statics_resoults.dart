import 'package:flutter/material.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/utility/data_transform.dart';
import 'package:world_cup/utility/size_config.dart';

class PredictionsStaticsResoults extends StatelessWidget {
  final Match match;
  const PredictionsStaticsResoults({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    List<dynamic> values = match.statisticRe!.values.toList();
    if (match.statisticRe == null || match.statisticRe!.keys.isEmpty) {
      return const Center(
        child: Text('No data Available yet'),
      );
    }

    return Center(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (ctx, i) {
          int itemsWidth = match.predictions!.length;
          int itemWidth = match.statisticRe!.values.toList()[i];
          double widgetLength = 100;
          double cWidth = (itemWidth / itemsWidth) * widgetLength;

          return Visibility(
            visible: values[i] != 0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                color: Colors.white.withOpacity(0.08),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 35,
                      child: Text(
                        match.matchStaticsReText(
                                match.statisticRe!.keys.toList()[i]) ??
                            '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: getPercentScreenWidth(3),
                        right: getPercentScreenWidth(3)),
                    decoration: BoxDecoration(
                      color: match.matchStaticsReColor(
                        match.statisticRe!.keys.toList()[i],
                      ),
                    ),
                    alignment: Alignment.center,
                    height: getPercentScreenHeight(6),
                    width:
                        getPercentScreenWidth(cWidth - ((40 / 100) * cWidth)),
                    child: Text(
                      '${cWidth.round()}%',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
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
                      child: Text(
                          voteCount(match.statisticRe!.values.toList()[i])),
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
