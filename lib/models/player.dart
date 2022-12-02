import 'dart:math';

import 'package:world_cup/models/player_predictions.dart';
import 'package:flutter/material.dart';

class Player {
  int? id;
  String? firstName;
  String? lastname;
  String? email;
  String? totalPints;
  int? rank;
  PlayerPredictions? playerPredictions;
  int? rankChange;
  RankStatus? status;

  Player(
      {this.email,
      this.firstName,
      this.id,
      this.lastname,
      this.rank,
      this.totalPints,
      this.playerPredictions,
      this.rankChange});

  Player.fromJson(json) {
    id = json['id'];
    firstName = json['first_name'];
    lastname = json['last_name'];
    email = json['email'];
    totalPints = json['total_points'];
    rank = json['rank'];
    status = statusValue(json['rank_change']);
  }

  RankStatus statusValue(int? rankChange) {
    if (rankChange == null) return RankStatus.still;
    if (rankChange == 1) return RankStatus.improved;
    if (rankChange > 1) return RankStatus.greatlyImproved;
    if (rankChange == -1) return RankStatus.decrased;
    if (rankChange < -1) return RankStatus.greatlyDecrased;
    return RankStatus.still;
  }

  String? get name {
    return '$firstName $lastname';
  }

  Widget get rankChnageIcon {
    switch (status) {
      case RankStatus.improved:
        return SizedBox(
          height: 20,
          width: 20,
          child: Stack(children: const [
            Positioned(
              right: 7,
              child: SizedBox(
                width: 10,
                height: 15,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.greenAccent,
                  size: 17,
                ),
              ),
            ),
          ]),
        );
      case RankStatus.greatlyImproved:
        return SizedBox(
          height: 20,
          width: 20,
          child: Stack(children: const [
            Positioned(
              right: 7,
              child: SizedBox(
                width: 10,
                height: 15,
                child: Icon(
                  Icons.keyboard_double_arrow_up_sharp,
                  color: Colors.greenAccent,
                  size: 17,
                ),
              ),
            ),
          ]),
        );
      case RankStatus.decrased:
        return SizedBox(
          height: 20,
          width: 20,
          child: Stack(children: const [
            Positioned(
              right: 7,
              child: SizedBox(
                width: 10,
                height: 15,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.red,
                  size: 17,
                ),
              ),
            ),
          ]),
        );
      case RankStatus.greatlyDecrased:
        return SizedBox(
          height: 20,
          width: 20,
          child: Stack(children: const [
            Positioned(
              right: 7,
              child: SizedBox(
                width: 10,
                height: 15,
                child: Icon(
                  Icons.keyboard_double_arrow_down,
                  color: Colors.red,
                  size: 17,
                ),
              ),
            ),
          ]),
        );
      default:
        return SizedBox(
          height: 20,
          width: 20,
          child: Stack(children: [
            Positioned(
              right: 3,
              child: SizedBox(
                width: 10,
                height: 15,
                child: Container(
                  // color: Colors.red,
                  child: Text(
                    '-',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        );
    }
  }
}

enum RankStatus { improved, decrased, still, greatlyImproved, greatlyDecrased }
