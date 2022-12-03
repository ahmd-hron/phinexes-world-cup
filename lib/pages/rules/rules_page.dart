import 'package:flutter/material.dart';
import 'package:world_cup/pages/rules/components/rules_list.dart';
import 'package:world_cup/utility/size_config.dart';

class RulesPage extends StatelessWidget {
  static const String routeName = '/rules-page';
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Rules'))),
      body: const RulesList(),
    );
    // return Column(children: [
    //   Container(
    //       height: getPercentScreenHeight(8),
    //       margin: EdgeInsets.only(top: getPercentScreenHeight(6)),
    //       child: Center(
    //           child: Text(
    //         'Rules',
    //         style: Theme.of(context).textTheme.titleLarge,
    //       ))),
    //   const Expanded(child: RulesList())
    // ]);
  }
}
