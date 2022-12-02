import 'package:flutter/material.dart';
import 'package:world_cup/pages/settings%20page/components/settings_items.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings-page';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsItems();
  }
}
