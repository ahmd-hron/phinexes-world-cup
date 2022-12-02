import 'package:flutter/cupertino.dart';
import 'package:world_cup/models/error_model.dart';
import 'package:world_cup/models/player_predictions.dart';
import 'package:world_cup/services/predict_service.dart';
import 'package:world_cup/utility/snackbar.dart';

class PredictionProvider with ChangeNotifier {
  List<PlayerPredictions?> _predictions = [];
  List<PlayerPredictions?> get predictions => [..._predictions];

  Future<void> fetchPredictions(BuildContext context) async {
    try {
      _predictions = await PredictService.instance.fetchPredictions();
    } on ErrorModel catch (e) {
      showAppSnackBar(context, e.errorMessage);
    }
  }

  Future<void> fetchPlayerPrediction(int playerId) async {
    try {
      _predictions = await PredictService.instance.fetchPredictions(playerId);
    } on ErrorModel catch (e) {
      print(e.errorMessage);
    }
  }
}
