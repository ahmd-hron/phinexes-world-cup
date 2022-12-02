import 'package:dio/dio.dart';
import 'package:world_cup/models/error_model.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/resources/api.dart';
import 'package:world_cup/utility/data_transform.dart';

class MatchServices {
  MatchServices._();
  static final instance = MatchServices._();

  Future<List<Match>> fetchMatches([DateTime? time]) async {
    List<Match> matches = [];
    time ??= today;
    try {
      final date = time.toString();
      Response<dynamic>? response;
      response = await Api().dio.get('player/matches/list',
          queryParameters: {'date': date}).catchError((dioError) {
        DioError error = dioError;
        ErrorModel appError;
        if (error.response == null) {
          appError = ErrorModel.fromNull();
        } else {
          appError = ErrorModel.fromJson(dioError.response?.data);
        }
        throw appError;
      });
      for (var i = 0; i < response.data.length; i++) {
        final match = Match.fromJson(response.data[i]);
        matches.add(match);
      }
    } on ErrorModel {
      matches = [];
      rethrow;
    }
    return matches;
  }

  Future<List<Match>> fetchAll() async {
    List<Match> matches = [];
    try {
      Response<dynamic>? response;
      response =
          await Api().dio.get('player/matches/list').catchError((dioError) {
        DioError error = dioError;
        ErrorModel appError;
        if (error.response == null) {
          appError = ErrorModel.fromNull();
        } else {
          appError = ErrorModel.fromJson(dioError.response?.data);
        }
        throw appError;
      });
      for (var i = 0; i < response.data.length; i++) {
        final match = Match.fromJson(response.data[i]);
        matches.add(match);
      }
    } on ErrorModel {
      matches = [];
      rethrow;
    }
    return matches;
  }
}
