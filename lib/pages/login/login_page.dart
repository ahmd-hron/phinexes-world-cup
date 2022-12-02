import 'package:flutter/material.dart';
import 'package:world_cup/pages/login/components/login_form.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/login-page';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(child: LoginForm()),
    );
  }
}
