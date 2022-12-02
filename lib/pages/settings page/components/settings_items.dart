import 'package:flutter/material.dart';
import 'package:world_cup/pages/settings%20page/components/setting_item.dart';

class SettingsItems extends StatelessWidget {
  const SettingsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SettingItem(
          label: 'Dark Mode',
          trail: Switch(
            onChanged: (value) {},
            value: true,
            activeColor: Theme.of(context).primaryColor,
          ),
        ),
        SettingItem(label: 'Logout')
      ],
    );
  }
}
