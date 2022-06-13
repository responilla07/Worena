import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:word_game/models/models.dart';

class PlayersStream {
  final int _limit = 8;
  var database = FirebaseFirestore.instance;
  var usersCollection = FirebaseFirestore.instance.collection('Users');
  StreamSubscription<QuerySnapshot> playerStream;
  Future<QuerySnapshot> futureSnapshot;
  DocumentSnapshot lastDoc;

  startPlayersStream({@required Function function }) async {
    playerStream = usersCollection.orderBy('game_record.lose', descending: true).snapshots().listen((snapshot) {
      function(snapshot);
    });
  }

  Future<List<UserDetailsModel>> getInitialPlayers() async {
    List<UserDetailsModel> list = [];
    futureSnapshot = usersCollection.where('status', isEqualTo: 'in-lobby').orderBy('game_record.lose', descending: true).limit(_limit).get();
    await futureSnapshot.then((QuerySnapshot query) {
      query.docs.forEach((data) {
        list.add(UserDetailsModel(data: data.data(), id: data.id));
        lastDoc = data;
      });
    });
    return list;
  }

  Future<List<UserDetailsModel>> geNewPlayers() async {
    List<UserDetailsModel> list = [];
    futureSnapshot = usersCollection.where('status', isEqualTo: 'in-lobby').orderBy('game_record.lose', descending: true).startAfterDocument(lastDoc).limit(_limit).get();

    await futureSnapshot.then((QuerySnapshot query) {
      query.docs.forEach((data) {
        list.add(UserDetailsModel(data: data.data(), id: data.id));
        lastDoc = data;
      });
    });
    return list;
  }

  Future<UserDetailsModel> geNewPlayerToInsert() async {
    UserDetailsModel player;
    futureSnapshot = usersCollection.where('status', isEqualTo: 'in-lobby').orderBy('game_record.lose', descending: true).startAfterDocument(lastDoc).limit(1).get();

    await futureSnapshot.then((QuerySnapshot query) {
      if (query.docs.isNotEmpty) {
        var data = query.docs[0];
        player = UserDetailsModel(data: data.data(), id: data.id);
        lastDoc = data;
      }
    });
    return player;
  }

  Future<String> sendInvitation({ @required InvitationModel invitation}) async {
    String message = "Failed to send invitation";
    var batch = FirebaseFirestore.instance.batch();
    
    batch.set(usersCollection.doc(invitation.senderID).collection('Invitations').doc(), invitation.setInvitation());
    batch.set(usersCollection.doc(invitation.playerID).collection('Invitations').doc(), invitation.setInvitation());

    await batch.commit().then((v) {
      message = "Invitation sent!";
    }).catchError((onError){
      message = "Invitation sent!";
    });
    
    return message;
  }

  closePlayersStream() {
    playerStream.cancel();
  } 
}