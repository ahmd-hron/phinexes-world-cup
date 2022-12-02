import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String label;
  final String? subtitle;
  final Widget? trail;
  final bool shouldAddDivider;
  const SettingItem(
      {this.shouldAddDivider = true,
      required this.label,
      this.subtitle,
      this.trail,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          title: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: subtitle == null
              ? null
              : Text(
                  '   $subtitle!',
                ),
          trailing: trail,
        ),
        if (shouldAddDivider) const Divider(height: 0),
      ],
    );
  }
}
