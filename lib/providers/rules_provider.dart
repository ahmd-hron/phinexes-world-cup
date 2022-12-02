import 'package:flutter/cupertino.dart';
import 'package:world_cup/models/error_model.dart';
import 'package:world_cup/models/rules.model.dart';
import 'package:world_cup/services/rules_service.dart';
import 'package:world_cup/utility/snackbar.dart';

class RulesProvider with ChangeNotifier {
  Rules? _rules;
  Rules? get rules => _rules;

  Future<bool> getRules(BuildContext context) async {
    try {
      _rules = await RulesService.instance.fetchRules();
    } on ErrorModel catch (e) {
      showAppSnackBar(context, e.errorMessage);
      return false;
    }
    return true;
  }
}
