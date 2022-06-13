import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:word_game/functions/log.dart';
import 'package:word_game/models/models.dart';
import 'package:word_game/services/account_details.dart';

class StartMatchMaking {
  var matchesCollection = FirebaseFirestore.instance.collection('Matches');
  var userCollection = FirebaseFirestore.instance.collection('Users');
  StreamSubscription<DocumentSnapshot> waitingForMatchedPlayer;
  MatchDetailsModel _match = MatchDetailsModel(data: {}, id: "not_found");
  Future<QuerySnapshot> futureSnapshot;
  var _userID = FirebaseAuth.instance.currentUser.uid;
  var _id;
  var matchMakingStatus = "in_queu";

  Future<MatchDetailsModel> findMatch({@required int points}) async {
    _match = MatchDetailsModel(data: {}, id: "not_found");
    var max = (points * 0.20).round();
    var min = (points * 0.10).round();
    var range = max + min;
    var maxPoints = points;
    var minPoints = points - range;
    var matchRank = Random().nextInt(range) + minPoints;
    _match.matchMMR = matchRank;

    futureSnapshot = matchesCollection
        .where('status', isEqualTo: 'in_queu')
        .where('match_mmr', isEqualTo: matchRank)
        .where('players.player_one_id',
            isNotEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();

    await futureSnapshot.then((query) async {
      if (query.docs.isNotEmpty) {
        var _batch = FirebaseFirestore.instance.batch();
        var doc = query.docs[Random().nextInt(query.docs.length)];
        _id = doc.id;
        _match = MatchDetailsModel(data: doc.data(), id: _id);
        _match.status = 'matched';

        _batch.update(matchesCollection.doc(_match.id), _match.setPlayerTwo());
        _batch.update(userCollection.doc(_userID),
            {'last_match': _match.setUserLastMatch()});

        logData(
            data:
                "Matched MMR: ${_match.matchMMR}, total of: ${query.docs.length}, matchID: ${_match.id}");
        await _batch.commit();
      } else {
        logData(data: "no match player for this mmr");
        _createNewMatch(
                maxPoints: maxPoints, minPoints: minPoints, match: _match)
            .then((match) => _match = match);
      }
    }).catchError((error) {
      throw error;
    });

    return _match;
  }

  Future<MatchDetailsModel> _createNewMatch(
      {@required int maxPoints,
      @required int minPoints,
      @required MatchDetailsModel match}) async {
    var _batch = FirebaseFirestore.instance.batch();
    _id = Uuid().v4();

    //For Future Update for earcning points
    // var max = (((maxPoints - minPoints) / 2) * 0.05).round();
    // var min = (max / 2).round();

    var max = 12;
    var min = 6;

    var pointsWin = Random().nextInt(max) + min;
    var pointsLose = Random().nextInt(max) + min;

    match.pointsEarn.pointsWin = pointsWin;
    match.pointsEarn.pointsLose = pointsLose;
    match.id = _id;
    match.status = 'in_queu';
    logData(data: "Match MMR: ${match.matchMMR}");

    _batch.set(matchesCollection.doc(match.id), match.setMatch());
    _batch.update(userCollection.doc(_userID), {
      'last_match': match.setUserLastMatch(),
    });

    await _batch.commit();
    logData(data: _id);
    return match;
  }

  startWaitingForMatchedPlayer({@required Function function}) async {
    logData(data: _id);
    waitingForMatchedPlayer =
        matchesCollection.doc(_id).snapshots().listen((doc) {
      if (doc.exists) {
        _match = MatchDetailsModel(data: doc.data(), id: doc.id);
      } else {
        _match = MatchDetailsModel(data: {}, id: "not_found");
      }
      function(_match);
    });
  }

  acceptMatch() {
    var _batch = FirebaseFirestore.instance.batch();
    // _match
    _batch.update(matchesCollection.doc(_match.id), _match.startMatch());
  }

  stopWaitingForMatchedPlayer() {
    waitingForMatchedPlayer?.cancel();
  }

  stopMatchMaking() async {
    stopWaitingForMatchedPlayer();
    var _batch = FirebaseFirestore.instance.batch();

    _batch.delete(matchesCollection.doc(_id));
    _batch.update(
        userCollection.doc(_userID), accountDetails.value.removeLastMatch());

    await _batch
        .commit()
        .then((value) => _match = MatchDetailsModel(data: {}, id: "not_found"));
  }
}
