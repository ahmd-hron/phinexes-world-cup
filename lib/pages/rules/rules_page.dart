import 'package:flutter/material.dart';
import 'package:world_cup/pages/rules/components/rules_list.dart';

class RulesPage extends StatelessWidget {
  static const String routeName = '/rules-page';
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RulesList();
  }
}
