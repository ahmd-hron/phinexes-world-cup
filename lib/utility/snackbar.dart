import 'package:flutter/material.dart';

void showAppSnackBar(BuildContext context, String? messege) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 1500),
    elevation: 5,
    content: Text(
      messege ?? '',
    ),
    action: SnackBarAction(
      onPressed: () {
        ScaffoldMessenger.maybeOf(context)!.clearSnackBars();
      },
      label: 'Close',
    ),
  ));
}
