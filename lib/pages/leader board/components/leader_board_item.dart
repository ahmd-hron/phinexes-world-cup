import 'package:flutter/material.dart';
import 'package:world_cup/models/player.dart';
import 'package:world_cup/utility/size_config.dart';
import 'package:world_cup/widgets/player_prediction_dialog.dart';

class LeaderBoardItem extends StatelessWidget {
  final Player player;
  const LeaderBoardItem({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: Column(children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return PlayerPredictionDialog(player: player);
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: getPercentScreenWidth(15),
                    child: Container(
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          player.rankChnageIcon,
                          SizedBox(
                            width: getPercentScreenWidth(5),
                            child: Text(
                              '${player.rank}',
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                    width: getPercentScreenWidth(45),
                    child: Text(
                      player.name ?? '',
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                    width: getPercentScreenWidth(15),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        '${player.totalPints}',
                        textAlign: TextAlign.end,
                      ),
                    )),
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
          height: 5,
        )
      ]),
    );
  }
}
