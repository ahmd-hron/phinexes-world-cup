import 'package:dio/dio.dart';
import 'package:world_cup/models/error_model.dart';
import 'package:world_cup/models/rules.model.dart';
import 'package:world_cup/resources/api.dart';

class RulesService {
  RulesService._();
  static final RulesService instance = RulesService._();

  Future<Rules?> fetchRules() async {
    try {
      final response =
          await Api().dio.get('player/predictions/rules').catchError((e) {
        DioError dioError = e;
        ErrorModel appError;
        if (dioError.response == null) {
          appError = ErrorModel.fromNull();
        } else {
          appError = ErrorModel.fromJson(dioError.response!.data);
        }
        throw appError;
      });
      final Rules rules = Rules.fromJson(response.data);
      return rules;
    } on ErrorModel {
      rethrow;
    }
  }
}
