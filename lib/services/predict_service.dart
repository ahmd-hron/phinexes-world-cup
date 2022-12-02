import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:world_cup/models/error_model.dart';
import 'package:world_cup/models/player_predictions.dart';
import 'package:world_cup/models/predict.dart';
import 'package:world_cup/resources/api.dart';

class PredictService {
  PredictService._();
  static final instance = PredictService._();

  Future<Predictions?> sendPredict(int matchId, int home, int away) async {
    final data = json.encode({
      "home_score_predict": home,
      "away_score_predict": away,
    });
    try {
      final response =
          await Api().dio.post('player/matches/$matchId/predict', data: data);
      return Predictions.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PlayerPredictions?>> fetchPredictions([int? id]) async {
    List<PlayerPredictions?> predictions = [];
    try {
      String path = id == null
          ? 'player/predictions/list'
          : 'player/predictions/list/$id';
      final response = await Api().dio.get(path).catchError((e) {
        DioError dioError = e;
        ErrorModel appErorr;
        if (dioError.response == null) {
          appErorr = ErrorModel.fromNull();
        } else {
          appErorr = ErrorModel.fromJson(dioError.response!.data);
        }
        throw appErorr;
      });
      for (var i = 0; i < response.data.length; i++) {
        final predict = PlayerPredictions.fromJson(response.data[i]);
        predictions.add(predict);
      }
    } on ErrorModel {
      rethrow;
    }
    return predictions;
  }
}
