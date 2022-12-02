import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/providers/auth_provider.dart';
import 'package:world_cup/utility/size_config.dart';
import 'package:world_cup/widgets/app_input_field.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final oldPasswordController = TextEditingController();
  final newPassWordController = TextEditingController();
  final confirmPassWordController = TextEditingController();
  final oldNode = FocusNode();
  final newNode = FocusNode();
  final confirmNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPassWordController.dispose();
    confirmPassWordController.dispose();
    oldNode.dispose();
    newNode.dispose();
    confirmNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SizedBox(
      width: getPercentScreenWidth(100),
      height: getPercentScreenHeight(73),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getPercentScreenWidth(15),
              vertical: getPercentScreenHeight(10)),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppInputField(
                  title: 'old Password',
                  controller: oldPasswordController,
                  focusNode: oldNode,
                  hint: '',
                  onChange: authProvider.updateOldPassword,
                  inputType: AppInputType.password,
                  height: 8,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                AppInputField(
                  title: 'new Password',
                  controller: newPassWordController,
                  focusNode: newNode,
                  hint: '',
                  onChange: authProvider.updateNewpassword,
                  inputType: AppInputType.password,
                  height: 8,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                AppInputField(
                  title: 'confirm Password',
                  controller: confirmPassWordController,
                  focusNode: confirmNode,
                  onChange: authProvider.updateConfirmmPassword,
                  hint: '',
                  inputType: AppInputType.password,
                  height: 8,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                if (authProvider.errorMessage != null)
                  Text(
                    authProvider.errorMessage ?? '',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                Center(
                  child: authProvider.loading
                      ? const Padding(
                          padding: EdgeInsets.all(5),
                          child: CircularProgressIndicator())
                      : TextButton(
                          onPressed: () async {
                            bool success = await authProvider.changePassword();
                            if (success) Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
