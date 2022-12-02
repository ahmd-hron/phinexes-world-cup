// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/providers/app_state_provier.dart';
import 'package:world_cup/providers/auth_provider.dart';
import 'package:world_cup/utility/scaffold_messenger.dart';
import 'package:world_cup/utility/size_config.dart';
import 'package:world_cup/widgets/app_input_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailFocuseNode = FocusNode();
  final passwordFocuseNode = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailFocuseNode.dispose();
    passwordFocuseNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.all(10),
      color: Colors.white.withOpacity(0.02),
      width: getPercentScreenWidth(90),
      height: getPercentScreenHeight(50),
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppInputField(
            title: 'Email',
            controller: emailController,
            focusNode: emailFocuseNode,
            validate: (value) {
              if (value == null) return 'Please enter your email';
              return null;
            },
            hint: '',
            inputType: AppInputType.email,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          AppInputField(
            title: 'Password',
            controller: passwordController,
            focusNode: passwordFocuseNode,
            hint: '',
            inputType: AppInputType.password,
          ),
          Row(
            children: [
              const Text('Did you forgot your password?'),
              TextButton(
                onPressed: () async {
                  await Messenger.instance.showSnackBar('Too bad you\'r out ');
                  await Future.delayed(Duration(seconds: 2));
                  Messenger.instance.scaffoldState.currentState!
                      .clearSnackBars();
                  Messenger.instance.scaffoldState.currentState!
                      .showSnackBar(Messenger.instance.jokeOne());
                },
                child: const Text(
                  'click here',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: getPercentScreenHeight(5))),
          Consumer<AuthProvider>(
            builder: (context, value, child) {
              if (value.loading) return const CircularProgressIndicator();
              return TextButton(
                onPressed: () async {
                  bool succ = await value.login(
                      emailController.text, passwordController.text);
                  if (succ) {
                    Provider.of<AppStateProvider>(context, listen: false)
                        .update();
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              );
            },
          )
        ],
      )),
    );
  }
}
