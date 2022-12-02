import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/providers/theme_provider.dart';
import 'package:world_cup/utility/size_config.dart';

class AppStateProvider extends ChangeNotifier {
  bool sizeInit = false;

  Future<void> initSize(BuildContext context) async {
    await SizeConfig.instance.init(context);
    sizeInit = true;
    notifyListeners();
  }

  Future<void> changedTheme(BuildContext context, bool isOn) async {
    Provider.of<ThemeManager>(context, listen: false).toggleDarkTheme(isOn);
    notifyListeners();
  }

  update() {
    notifyListeners();
  }
}
