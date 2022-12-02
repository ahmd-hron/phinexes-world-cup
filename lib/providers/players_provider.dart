import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:world_cup/models/error_model.dart';
import 'package:world_cup/models/player.dart';
import 'package:world_cup/services/players_service.dart';
import 'package:world_cup/utility/snackbar.dart';

class PlayersProvider with ChangeNotifier {
  List<Player> _players = [];

  List<Player> get players => [..._players];
  bool _loading = false;
  bool get loading => _loading;

  Future<bool> fetchPlayers(BuildContext context, DateTime? time,
      [bool updaetListenrs = true]) async {
    try {
      toggleLoading(true, updaetListenrs);
      _players = await PlayerService.instance.fetchPlayers(time);
      toggleLoading(false, updaetListenrs);
      return true;
    } on ErrorModel catch (e) {
      showAppSnackBar(context, e.errorMessage);
      toggleLoading(false, updaetListenrs);
      return false;
    }
  }

  toggleLoading(value, [bool update = true]) {
    _loading = value;
    if (update) notifyListeners();
  }

  clearPlayers() {
    _players = [];
    print('despoed players');
  }
}
