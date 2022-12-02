import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/providers/app_state_provier.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AppStateProvider>(context, listen: false).initSize(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
