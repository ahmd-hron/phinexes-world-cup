import 'package:flutter/cupertino.dart';
import 'package:world_cup/services/total_points_service.dart';

class TotalPointsProvider with ChangeNotifier {
  int totalPoints = 0;

  Future<void> getTotalPoints() async {
    totalPoints = await TotalPointsService.instance.fetchPoints();
    notifyListeners();
  }
}
