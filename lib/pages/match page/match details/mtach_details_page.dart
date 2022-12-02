import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/pages/match%20page/components/predection_list.dart';
import 'package:world_cup/pages/match%20page/match%20details/components/match_details_body.dart';
import 'package:world_cup/utility/size_config.dart';

class MatchDetails extends StatelessWidget {
  final Match match;
  const MatchDetails({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: getPercentScreenHeight(3)),
      child: ContainedTabBarView(
        initialIndex: 1,
        tabs: const [Text('Statistics'), Text('Team Predictions')],
        views: [
          MatchDetailsBody(
            match: match,
          ),
          SizedBox(
            child: Column(
              children: [
                Expanded(child: PredectionList(match: match)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
