import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/pages/leader%20board/components/leader_board_item.dart';
import 'package:world_cup/providers/players_provider.dart';
import 'package:world_cup/utility/size_config.dart';

class LeaderBoardList extends StatefulWidget {
  final DateTime time;
  const LeaderBoardList({super.key, required this.time});

  @override
  State<LeaderBoardList> createState() => _LeaderBoardListState();
}

class _LeaderBoardListState extends State<LeaderBoardList> {
  bool loading = true;

  @override
  void didChangeDependencies() {
    print('rebuilt leaderboard page');
    Provider.of<PlayersProvider>(context, listen: false)
        .fetchPlayers(context, widget.time, false)
        .then((value) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final playersProvider = Provider.of<PlayersProvider>(context);
    loading = playersProvider.loading;
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            height: getPercentScreenHeight(90),
            child: Column(children: [
              Container(
                // height: getPercentScreenHeight(8),
                width: getPercentScreenWidth(100),
                margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: getPercentScreenWidth(25),
                        child: Text(
                          'Rank',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                        width: getPercentScreenWidth(25),
                        child: Text(
                          'Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                        width: getPercentScreenWidth(25),
                        child: Text(
                          'Total Points',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 5,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: playersProvider.players.length,
                    itemBuilder: (ctx, i) {
                      if (playersProvider.players.isEmpty) {
                        return const Center(
                          child: Text('No records found :('),
                        );
                      } else {
                        return LeaderBoardItem(
                            player: playersProvider.players[i]);
                      }
                    },
                  ),
                ),
              ),
            ]),
          );
  }
}
