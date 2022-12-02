import 'package:flutter/material.dart';
import 'package:world_cup/pages/change%20password/components/password_form.dart';

class ChangePasswordPage extends StatelessWidget {
  static const String routeName = '/change-password-page';
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'Change Password',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
      body: const ChangePasswordForm(),
    );
  }
}
