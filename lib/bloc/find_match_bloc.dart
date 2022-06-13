import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:word_game/functions/log.dart';
import 'package:word_game/models/models.dart';
import 'package:word_game/services/services.dart';

part 'find_match_event.dart';
part 'find_match_state.dart';

class FindMatchBloc extends Bloc<FindMatchEvent, FindMatchState> {
  final StartMatchMaking matchMaking;
  FindMatchBloc({@required this.matchMaking})
      : assert(matchMaking != null),
        super(FindMatchInitial());

  @override
  Stream<FindMatchState> mapEventToState(
    FindMatchEvent event,
  ) async* {
    try {
      if (event is LoadInitialMatchMaking) {
        yield FindMatchInitial();
        yield InitialMatchMakingLoaded();
      }

      if (event is FindMatchPlayer) {
        yield MatchMakingStarted();
        await Future.delayed(
            Duration(seconds: 2), () {}); // TODO remove after testing
        MatchDetailsModel _match = MatchDetailsModel(data: {}, id: "");

        // await matchMaking.findMatch(points: 5).then((match) {
        await matchMaking.findMatch(points: event.points).then((match) {
          _match = match;
        });

        if (_match.status == 'in_queu') {
          yield MatchContinueQueuing();
        }
        if (_match.status == 'matched') {
          yield MatchFound(); 
        }

      }

      if (event is AcceptMatch) {
        await matchMaking.acceptMatch();
      }

      if (event is DeclineMatch) {
        await matchMaking.stopMatchMaking();
        yield MatchDeclined();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}


// FirebaseFirestore.instance.collection('Matches').get().then((q) {
//           var _batch = FirebaseFirestore.instance.batch();
//           q.docs.forEach((doc) {
//           _batch.update(FirebaseFirestore.instance.collection('Matches').doc(doc.id), {
//             'players.player_one_id' : 'm17kbqh3Lfaxr8dERhrBTdAGHqr1'
//           });
//           });
//           _batch.commit();
//         });