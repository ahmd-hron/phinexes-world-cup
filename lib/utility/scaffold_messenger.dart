import 'package:flutter/material.dart';
import 'package:world_cup/utility/size_config.dart';

class Messenger {
  Messenger._();
  static final instance = Messenger._();

  var scaffoldState = GlobalKey<ScaffoldMessengerState>();

  Future showSnackBar(String? messege) async {
    return scaffoldState.currentState!
        .showSnackBar(interceptorSnackbar(messege));
  }

  Future showJokeBar(String? messege) async {
    return scaffoldState.currentState!.showSnackBar(jokeOne());
  }

  SnackBar interceptorSnackbar(String? messege) {
    return SnackBar(
      duration: const Duration(milliseconds: 1500),
      elevation: 5,
      content: Text(
        messege ?? 'Please check your internet connection and try again ',
      ),
      action: SnackBarAction(
        onPressed: () {
          Messenger.instance.scaffoldState.currentState!.clearSnackBars();
        },
        label: 'Close',
      ),
    );
  }

  SnackBar JokeBar(String? message) {
    return SnackBar(
      content: const Center(child: Text('2-0')),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: getPercentScreenHeight(100) - 100, right: 20, left: 20),
    );
  }

  SnackBar jokeOne() {
    return SnackBar(
      duration: const Duration(milliseconds: 1500),
      elevation: 5,
      content: const Text(
        'Joking',
      ),
      action: SnackBarAction(
        onPressed: () {
          Messenger.instance.scaffoldState.currentState!
              .showSnackBar(JokeBar('got you again 2-0 you still out'));
        },
        label: 'Click here',
      ),
    );
  }
}
