import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/models/team.dart';
import 'package:world_cup/pages/match%20page/components/predict_card.dart';
import 'package:world_cup/pages/match%20page/match%20details/mtach_details_page.dart';
import 'package:world_cup/utility/data_transform.dart';
import 'package:world_cup/utility/size_config.dart';

class MatchWidget extends StatelessWidget {
  Match? match;
  MatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final match = Provider.of<Match>(context);
    return SizedBox(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (match.predictions!.isEmpty) {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Ok'))
                        ],
                        content: const Text(
                          'no data Available',
                        ),
                      );
                    });
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MatchDetails(match: match),
                ),
              );
            },
            child: SizedBox(
              height: getPercentScreenHeight(20),
              width: getPercentScreenWidth(90),
              child: Card(
                color: Colors.white.withOpacity(0.08),
                elevation: 4,
                margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
                child: SizedBox(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(getTime(localDate(match.startTime!))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            nationColumn(match.homeTeam!, context),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: getPercentScreenHeight(3)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      matchScore(context),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .color,
                                        fontSize: 20,
                                      ),
                                    ),
                                    if (matchOverTimeScore(context) != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          matchOverTimeScore(context) ?? '',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    if (matchPentliesScore(context) != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 3.0),
                                        child: Text(
                                          matchPentliesScore(context) ?? '',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                  ]),
                            ),
                            nationColumn(match.awayTeam!, context)
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
          PredictCard(
            match: match,
          ),
        ],
      ),
    );
  }

  Widget nationColumn(Team team, ctx) {
    return Column(
      children: [
        imageContainer(team.imageUrl, ctx),
        Padding(padding: EdgeInsets.only(top: getPercentScreenHeight(3))),
        Text(
          team.nameCode!,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget imageContainer(imageUrl, ctx) {
    return SizedBox(
      height: getPercentScreenHeight(8),
      width: getPercentScreenWidth(30),
      child: FittedBox(
          fit: BoxFit.contain,
          child: Image.network(
            imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return const Text('Loading failed ');
            },
          )),
    );
  }

  String matchScore(BuildContext context) {
    final match = Provider.of<Match>(context);
    if (!match.hasStarted) return 'Vs';
    if ((match.hasStarted && match.homeTeam!.score == null) ||
        match.awayTeam!.score == null) return 'now';
    if (match.homeTeam!.score == null) return ' ';
    return '${match.homeTeam!.score} - ${match.awayTeam!.score}';
  }

  String? matchOverTimeScore(BuildContext context) {
    final match = Provider.of<Match>(context);
    if (match.homeTeam!.scoreOvertime != null) {
      return '(${match.homeTeam!.scoreOvertime} - ${match.awayTeam!.scoreOvertime})';
    } else {
      return null;
    }
  }

  String? matchPentliesScore(BuildContext context) {
    final match = Provider.of<Match>(context);
    if (match.homeTeam!.scorePenalties != null) {
      return '(${match.homeTeam!.scorePenalties} - ${match.awayTeam!.scorePenalties})';
    } else {
      return null;
    }
  }
}
