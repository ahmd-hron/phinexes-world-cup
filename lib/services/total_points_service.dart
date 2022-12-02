import 'package:world_cup/resources/api.dart';

class TotalPointsService {
  TotalPointsService._();
  static TotalPointsService get instance => TotalPointsService._();

  Future<int> fetchPoints() async {
    int points = 0;
    try {
      final response = await Api().dio.get('player/predictions/total');
      points = response.data['total_points'];
    } catch (e) {
      return points;
    }
    return points;
  }
}
