import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'match_details_model.dart';

class UserDetailsModel {
  Name name;
  GameRecord gameRecord;
  MatchDetailsModel matchHistory;
  String email;
  String inGameName;
  String id;
  String picURI;
  String status;
  List<dynamic> invitations;
  Badges badge;
  int mmrPoints;

  UserDetailsModel(
      {@required Map<dynamic, dynamic> data, @required String id}) {
    this.id = id ?? "";
    this.name = Name(data: data['name_details'] ?? {});
    this.gameRecord = GameRecord(data: data['game_record'] ?? {});
    this.matchHistory =
        MatchDetailsModel(data: data['last_match'] ?? {}, id: "n/a");
    this.email = data['email'] ?? "user@gmail.com";
    this.inGameName = data['in_game_name'] ?? "loading...";
    this.picURI = data['picture'] ?? "";
    this.status = data['status'] ?? "";
    this.invitations = data['invitations'] ?? [];
    this.badge = Badges(data: data["badge"] ?? {});
    this.mmrPoints = data['mmr_points'] ?? 800;
  }

  Map<String, dynamic> setUserDetailsModel() {
    return {
      'name_details': this.name.setName(),
      'game_record': this.gameRecord.setGameRecord(),
      'last_match': this.matchHistory.setUserLastMatch(),
      'email': this.email,
      'in_game_name': this.inGameName,
      'picture': this.picURI,
      'status': 'account_created',
      'invitations': this.invitations,
      'badges_count': this.badge,
      'date_updated': FieldValue.serverTimestamp(),
      'date_created': FieldValue.serverTimestamp(),
      'mmr_points': this.mmrPoints,
    };
  }

  Map<String, dynamic> updateUserDetailsModel() {
    return {
      'name_details': this.name.setName(),
      'email': this.email,
      'in_game_name': this.inGameName,
      'picture': this.picURI,
      'date_updated': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> removeLastMatch() {
    return {
      'status': 'in_lobby',
      'last_match': {},
    };
  }
}

class Name {
  String fullName;
  String firstName;
  String lastName;

  Name({@required Map<dynamic, dynamic> data}) {
    this.fullName = data['full_name'] ?? "";
    this.firstName = data['first_name'] ?? "";
    this.lastName = data['last_name'] ?? "";
  }

  Map<String, dynamic> setName() {
    return {
      'full_name': this.fullName,
      'first_name': this.firstName,
      'last_name': this.lastName,
    };
  }
}

class GameRecord {
  int lose;
  int win;
  String winrate;

  GameRecord({@required Map<dynamic, dynamic> data}) {
    this.lose = data['lose'] ?? 0;
    this.win = data['win'] ?? 0;
    this.winrate = data['win_rate'] ?? "00";
  }

  Map<String, dynamic> setGameRecord() {
    return {
      'lose': this.lose,
      'win': this.win,
      'win_rate': this.winrate,
    };
  }
}

class Badges {
  int trophy;
  int invites;
  int inbox;

  Badges({@required Map<dynamic, dynamic> data}) {
    this.trophy = data['trophy'] ?? 0;
    this.invites = data['invites'] ?? 0;
    this.inbox = data['inbox'] ?? 0;
  }

  Map<String, dynamic> setGameRecord() {
    return {
      'trophy': this.trophy,
      'invites': this.invites,
      'inbox': this.inbox,
    };
  }
}
