import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/pages/profile/components/prediction_item.dart';
import 'package:world_cup/providers/prediction_provider.dart';
import 'package:world_cup/utility/size_config.dart';

class PredictionList extends StatefulWidget {
  const PredictionList({super.key});

  @override
  State<PredictionList> createState() => _PredictionListState();
}

class _PredictionListState extends State<PredictionList> {
  bool loading = true;

  @override
  void didChangeDependencies() {
    Provider.of<PredictionProvider>(context)
        .fetchPredictions(context)
        .then((value) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.didChangeDependencies();
  }

  //should be 75
  @override
  Widget build(BuildContext context) {
    return loading
        ? SizedBox(
            height: getPercentScreenHeight(70),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            margin: const EdgeInsets.all(5),
            height: getPercentScreenHeight(70),
            child: Card(
              color: Colors.white.withOpacity(0.08),
              elevation: 4,
              margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Consumer<PredictionProvider>(
                  builder: (context, value, child) => ListView.builder(
                    itemCount: value.predictions.length,
                    itemBuilder: (context, i) {
                      if (value.predictions.isEmpty) {
                        return const Text('No data to show :(');
                      }
                      return PredictionItem(predictions: value.predictions[i]!);
                    },
                  ),
                ),
              ),
            ),
          );
  }

  /* @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : myPredictions == null
            ? const Center(
                child: Text('Something went wrong :('),
              )
            : SizedBox(
                height: getPercentScreenHeight(70),
                child: ListView.builder(
                  itemCount: myPredictions!.predictions!.length,
                  itemBuilder: (ctx, i) {
                    return Card(
                      color: Colors.white.withOpacity(0.08),
                      elevation: 4,
                      margin:
                          const EdgeInsets.only(top: 10, right: 15, left: 15),
                      child: Center(
                        child: Container(
                          child: Row(
                            children: [
                              Text('${myPredictions!.predictions![i]}'),
                              //match date
                              //awarded points
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
  }*/

}
