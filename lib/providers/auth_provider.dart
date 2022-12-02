import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/providers/app_state_provier.dart';
import 'package:world_cup/providers/user_provider.dart';
import 'package:world_cup/services/auth_service.dart';
import 'package:world_cup/utility/change_password_validator.dart';

class AuthProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  String? errorMessage;
  String? _oldPassword;
  String? _newPassword;
  String? _confirmPassword;

  Future<bool> login(String? email, String? password) async {
    bool sucess = true;
    updateLoading(true);
    try {
      String? token = await AuthService.instance.login(email, password);
      await UserData.instance
          .saveUserData(email, password, token, DateTime.now());
      sucess = true;
    } catch (e) {
      sucess = false;
    }
    updateLoading(false);
    return sucess;
  }

  void logout(BuildContext context) {
    print('clearing data');
    UserData.instance.clearData();
    print('logging out');
    Provider.of<AppStateProvider>(context, listen: false).update();
  }

  Future<bool> changePassword() async {
    bool valid = validatePasswordChange();
    if (!valid) return false;
    updateLoading(true);
    try {
      await AuthService.instance.changePassword(_oldPassword!, _newPassword!);
    } catch (e) {
      return false;
    }
    updateLoading(false);
    return true;
  }

  updateLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateOldPassword(String? value) {
    _oldPassword = value;
  }

  void updateNewpassword(String? value) {
    _newPassword = value;
  }

  void updateConfirmmPassword(String? value) {
    _confirmPassword = value;
  }

  bool validatePasswordChange() {
    errorMessage = null;
    errorMessage ??=
        validateOldPassword(_oldPassword, UserData.instance.user!.password!);
    errorMessage ??= validateNewPassword(_newPassword);
    errorMessage ??= validatePasswordConfirm(_confirmPassword, _newPassword);
    notifyListeners();
    return errorMessage == null;
  }
}
