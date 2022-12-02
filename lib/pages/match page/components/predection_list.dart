import 'package:flutter/material.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/pages/match%20page/components/predection_item.dart';

class PredectionList extends StatelessWidget {
  final Match match;
  const PredectionList({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          itemCount: match.predictions == null ? 1 : match.predictions!.length,
          itemBuilder: (context, i) {
            if (match.predictions == null) {
              return const Text('No predictions available yet');
            }
            return PredectionItem(
              predict: match.predictions![i],
              match: match,
            );
          },
        ),
      ),
    ]);
  }
}
