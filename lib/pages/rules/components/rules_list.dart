import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/providers/rules_provider.dart';
import 'package:world_cup/utility/size_config.dart';

class RulesList extends StatefulWidget {
  const RulesList({super.key});

  @override
  State<RulesList> createState() => _RulesListState();
}

class _RulesListState extends State<RulesList> {
  bool loading = true;

  @override
  void didChangeDependencies() {
    Provider.of<RulesProvider>(context, listen: false)
        .getRules(context)
        .then((d) {
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
    final ruleProv = Provider.of<RulesProvider>(context);
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ruleProv.rules == null
            ? const Center(
                child: Text('something went wrong getting the rules '),
              )
            : Padding(
                padding: EdgeInsets.only(top: getPercentScreenHeight(10)),
                child: ListView.builder(
                  itemBuilder: (ctx, i) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
                          child: Column(children: [
                            Text(
                              '${i + 1}. ${ruleProv.rules!.rules![i]}',
                              textAlign: TextAlign.left,
                            ),
                            const Divider()
                          ]),
                        ),
                      ],
                    );
                  },
                  itemCount: ruleProv.rules!.rules!.length,
                ),
              );
  }
}
