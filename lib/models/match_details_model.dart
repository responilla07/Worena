import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MatchDetailsModel {
  final List map = [
    'assets/maps/canada.png',
    'assets/maps/china.png',
    'assets/maps/peru.png',
    'assets/maps/singapore.png',
    'assets/maps/usa.png',
  ];
  String id;
  String status;
  String winnerID;
  GamePlayers players;
  Map date;
  String matchId;
  String matchMap;
  PointsMMR pointsEarn;
  ScoresCount scores;
  int matchMMR;

  MatchDetailsModel(
      {@required Map<dynamic, dynamic> data, @required String id}) {
    this.id = id;
    this.matchId = data['match_id'] ?? "";
    this.status = data['status'] ?? 'failed';
    this.winnerID = data['winner_id'] ?? '';
    this.players = GamePlayers(data: data['players'] ?? {});
    this.date = data['date'] ?? {};
    this.matchMap = data['map'] ?? "";
    this.pointsEarn = PointsMMR(data: data['match_points'] ?? {});
    this.scores = ScoresCount(data: data['scores'] ?? {});
    this.matchMMR = data['match_mmr'] ?? 0;
  }

  Map<String, dynamic> setMatch() {
    return {
      'status': 'in_queu',
      'winner_id': this.winnerID,
      'players': this.players.setPlayers(),
      'date': {
        'queu': FieldValue.serverTimestamp(),
      },
      'match_points': this.pointsEarn.setPoints(),
      'scores': this.scores.setScore(),
      'map': map[Random().nextInt(5)],
      'match_mmr': this.matchMMR,
    };
  }

  Map<String, dynamic> setPlayerTwo() {
    return {
      'status': 'matched',
      'players.player_two_id': FirebaseAuth.instance.currentUser.uid,
      'date.matched': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> startMatch() {
    return {
      'status': 'started',
      'date.started': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> matchFinish() {
    return {
      'status': 'finish',
      'winner_id': this.winnerID,
      'date.finish': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> setUserLastMatch() {
    return {
      'id': this.id,
      'match_id': this.id,
      'status': 'in_queu',
      'winner_id': this.winnerID,
      'players': this.players.setPlayers(),
      'date': {
        'queu': FieldValue.serverTimestamp(),
      },
    };
  }

  Map<String, dynamic> updateUserLastMatch() {
    return {
      'id': this.id,
      'match_id': this.id,
      'status': this.status,
      'winner_id': this.winnerID,
      'players': this.players.setPlayers(),
      'date': this.date,
    };
  }
}

class PointsMMR {
  int pointsWin;
  int pointsLose;

  PointsMMR({@required Map<dynamic, dynamic> data}) {
    this.pointsWin = data['points_win'] ?? 0;
    this.pointsLose = data['points_win'] ?? 0;
  }

  Map<String, dynamic> setPoints() {
    return {
      'points_win': this.pointsWin,
      'points_lose': this.pointsLose,
    };
  }
}

class ScoresCount {
  int playerOne;
  int playerTwo;

  ScoresCount({@required Map<dynamic, dynamic> data}) {
    this.playerOne = data['player_one'] ?? 0;
    this.playerTwo = data['player_two'] ?? 0;
  }

  Map<String, dynamic> setScore() {
    return {
      'player_one': this.playerOne,
      'player_two': this.playerTwo,
    };
  }

  Map<String, dynamic> updatePlayerOne() {
    return {
      'player_one': FieldValue.increment(1),
    };
  }

  Map<String, dynamic> updatePlayerTwo() {
    return {
      'player_two': FieldValue.increment(1),
    };
  }
}

class GamePlayers {
  String playerOne;
  String playerTwo;

  GamePlayers({@required Map<dynamic, dynamic> data}) {
    this.playerOne = data['player_one_id'] ?? "";
    this.playerTwo = data['player_two_id'] ?? "";
  }

  Map<String, dynamic> setPlayers() {
    return {
      'player_one_id': FirebaseAuth.instance.currentUser.uid,
      'player_two_id': this.playerTwo,
    };
  }
}
