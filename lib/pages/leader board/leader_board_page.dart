import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/pages/leader%20board/components/leader_board_list.dart';
import 'package:world_cup/providers/players_provider.dart';
import 'package:world_cup/utility/data_transform.dart';

class LeaderBoardPage extends StatefulWidget {
  static const routeName = '/leader-board';
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  var time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
          //player points

          actions: [
            //filter by date defoult date is today
            Row(children: [
              Text(getShortDate(time)),
              IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: time,
                      firstDate: DateTime(2022, 11, 15),
                      lastDate: DateTime(2022, 12, 30),
                    ).then((value) {
                      print('value is $value');
                      if (value == null) return;
                      if (mounted) {
                        setState(() {
                          time = value;
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.date_range)),
            ]),
            //total points
          ]),
      body: LeaderBoardList(
        time: time,
        key: ValueKey(time),
      ),
    );
  }
}
