import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/models/player.dart';
import 'package:world_cup/pages/profile/components/prediction_item.dart';
import 'package:world_cup/pages/profile/components/profile_prediction_list.dart';
import 'package:world_cup/providers/prediction_provider.dart';
import 'package:world_cup/utility/size_config.dart';

class PlayerPredictionDialog extends StatefulWidget {
  final Player player;
  const PlayerPredictionDialog({super.key, required this.player});

  @override
  State<PlayerPredictionDialog> createState() => _PlayerPredictionDialogState();
}

class _PlayerPredictionDialogState extends State<PlayerPredictionDialog> {
  bool loading = true;

  @override
  void didChangeDependencies() {
    Provider.of<PredictionProvider>(context, listen: false)
        .fetchPlayerPrediction(widget.player.id!)
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
    return Dialog(
      elevation: 5,
      child: SizedBox(
        height: getPercentScreenHeight(65),
        child: Column(
          children: [
            SizedBox(
              height: getPercentScreenHeight(5),
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(widget.player.name!),
                  )),
            ),
            SizedBox(
              height: getPercentScreenHeight(60),
              width: getPercentScreenWidth(100),
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: getPercentScreenHeight(65),
                      child: Card(
                        color: Colors.white.withOpacity(0.08),
                        elevation: 4,
                        margin: const EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Consumer<PredictionProvider>(
                            builder: (context, value, child) =>
                                ListView.builder(
                              itemCount: value.predictions.length,
                              itemBuilder: (context, i) {
                                if (value.predictions.isEmpty) {
                                  return const Text('No data to show :(');
                                }
                                return PredictionItem(
                                  predictions: value.predictions[i]!,
                                  isMe: false,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
