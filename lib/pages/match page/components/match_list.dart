import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/models/local_match.dart';
import 'package:world_cup/providers/matches_provider.dart';
import 'package:world_cup/pages/match%20page/components/match_card.dart';
import 'package:world_cup/providers/notifications_provider.dart';
import 'package:world_cup/providers/user_provider.dart';
import 'package:world_cup/utility/size_config.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({super.key});

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  bool loading = true;
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> init() async {
    final matchProvider = Provider.of<MatchProvider>(context, listen: false);
    matchProvider.fetchMatches(context, updateListenrs: false).then((value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!matchProvider.matchesInit) {
          matchProvider.saveLocalMatches().then((value) async {
            UserData.instance.saveMatchesDate(matchProvider.matchTimes);
            await NotificationHelper.instance.initializeNotification();
            await NotificationHelper.instance.cancelAll();
            showNitification(matchProvider.matchTimes);
          });
        }
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);
    loading = matchProvider.loading;
    return loading
        ? const CircularProgressIndicator()
        : matchProvider.matches.isEmpty
            ? const Center(child: Text('No matches found :('))
            : ListView.builder(
                padding: EdgeInsets.only(
                  top: getPercentScreenHeight(1),
                  bottom: getPercentScreenHeight(5),
                ),
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: matchProvider.matches[i],
                  child: MatchWidget(
                    key: ValueKey(matchProvider.matches[i].id!),
                  ),
                ),
                itemCount: matchProvider.matches.length,
              );
  }

  void showNitification(List<LocalMatch> matches) {
    for (var i = 0; i < matches.length; i++) {
      if (matches[i].date?.day != DateTime.now().day) return;
      NotificationHelper.instance.showNotifications(
        matches[i].getTimeDifference(matches[i].date!, 30),
        matches[i].id!,
        '${matches[i].matchName!} starts in 30 min',
        '',
      );
    }
  }
}
/* void showNitification(List<LocalMatch> matches) {
    for (var i = 0; i < matches.length; i++) {
      if (!matches[i].userPredicted!) {
        NotificationHelper.instance.showNotifications(
          matches[i].getTimeDifference(matches[i].date!, 30),
          matches[i].id!,
          '${matches[i].matchName!} starts in 30 min',
          'Predict now!',
        );
      }
    }
  }*/
