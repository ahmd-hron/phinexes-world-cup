import 'package:dio/dio.dart';
import 'package:world_cup/models/error_model.dart';
import 'package:world_cup/models/player.dart';
import 'package:world_cup/resources/api.dart';
import 'package:world_cup/utility/data_transform.dart';

class PlayerService {
  PlayerService._();
  static final PlayerService instance = PlayerService._();

  Future<List<Player>> fetchPlayers(DateTime? time) async {
    List<Player> players = [];
    if (time == null) {
      time = today;
    } else {
      time = date(time);
    }

    try {
      final date = dateToString(time);
      final response = await Api().dio.get(
        'player/predictions/ranking',
        queryParameters: {'date': date},
      ).catchError((e) {
        DioError dioError = e;
        ErrorModel appError;

        if (dioError.response == null) {
          appError = ErrorModel.fromNull();
        } else {
          appError = ErrorModel.fromJson(dioError.response!.data);
        }
        throw appError;
      });
      print(' request rui data is ${response.requestOptions.uri}');
      for (var i = 0; i < response.data.length; i++) {
        final player = Player.fromJson(response.data[i]);
        players.add(player);
      }
    } on ErrorModel {
      players = [];
      rethrow;
    }
    return players;
  }
}
