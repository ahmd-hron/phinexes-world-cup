import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/pages/match%20page/components/match_list.dart';
import 'package:world_cup/providers/matches_provider.dart';
import 'package:world_cup/providers/user_point_provider.dart';
import 'package:world_cup/utility/data_transform.dart';

//contains upcoming games
class HomePage extends StatefulWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime time = DateTime.now();

  @override
  void initState() {
    Provider.of<TotalPointsProvider>(context, listen: false).getTotalPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          //player points
          leading: Center(
              child: Consumer<TotalPointsProvider>(
            builder: (context, value, child) =>
                Text(value.totalPoints.toString()),
          )),
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
                      if (value == null) return;
                      if (mounted) {
                        setState(() {
                          time = value;
                          matchProvider.fetchMatches(context, time: time);
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.date_range)),
            ]),
            //total points
          ]),
      body: const Center(
        child: MatchesList(),
      ),
    );
  }
}
