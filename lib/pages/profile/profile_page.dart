import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/pages/change%20password/change_password_page.dart';
import 'package:world_cup/pages/profile/components/profile_prediction_list.dart';
import 'package:world_cup/providers/auth_provider.dart';
import 'package:world_cup/utility/size_config.dart';

//contains each member
class Profile extends StatelessWidget {
  static const String routeName = '/my-profile';
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(top: getPercentScreenHeight(5)),
          child: const Center(
              child: Text(
            'Overall predictions',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ))),
      const PredictionList(),
      Padding(
          padding: EdgeInsets.only(top: getPercentScreenWidth(3)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            logOut(context),
            SizedBox(
              width: getPercentScreenWidth(5),
            ),
            changePassword(context)
          ])),
    ]);
  }

  Widget logOut(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return TextButton(
        onPressed: () => authProvider.logout(context),
        child: const Text('Logout'));
  }

  Widget changePassword(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ChangePasswordPage.routeName);
        },
        child: const Text('Change password'));
  }
}
