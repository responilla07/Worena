import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:word_game/models/models.dart';


String _currentUser = FirebaseAuth.instance.currentUser.uid;


class WordStream {
  StreamSubscription<QuerySnapshot> wordStream;

  startWordStream({
    Function function,
  }){
    wordStream = FirebaseFirestore.instance.collection('Dictionary').where("answered", isEqualTo: false).limit(1).snapshots().listen((snapshot) {
      function(snapshot);
    });
  }

  closeWordStream() {
    wordStream.cancel();
  }
}

class StreamMatchHistory {
  int _limit = 8;
  StreamSubscription<QuerySnapshot> streamMatchHistory;
  var matchHistoryCollection = FirebaseFirestore.instance.collection('Users').doc(_currentUser).collection('MatchHistory');
  Future<QuerySnapshot> futureSnapshot;
  DocumentSnapshot lastDoc;
  
  startMatchHistoryStream({
    Function function,
  }){
    streamMatchHistory = matchHistoryCollection.snapshots().listen((snapshot) {
      function(snapshot);
    });
  }

  Future<List<MatchDetailsModel>> getInitialMatchHistory() async {
    List<MatchDetailsModel> list = [];
    futureSnapshot = matchHistoryCollection.where('status', isEqualTo: 'finish').orderBy('date.finish', descending: true).limit(_limit).get();

    await futureSnapshot.then((query) {
      query.docs.forEach((data) {
        list.add(MatchDetailsModel(data: data.data(), id: data.id));
        lastDoc = data;
      });
    });
    return list;
  }
  
  Future<List<MatchDetailsModel>> getNewListOfMatchHistory() async {
    List<MatchDetailsModel> list = [];
    futureSnapshot = matchHistoryCollection.where('status', isEqualTo: 'finish').orderBy('date.finish', descending: true).startAfterDocument(lastDoc).limit(_limit).get();

    await futureSnapshot.then((query) {
      query.docs.forEach((data) {
        list.add(MatchDetailsModel(data: data.data(), id: data.id));
        lastDoc = data;
      });
    });

    return list;
  }


  closeMatchHistoryStream() {
    streamMatchHistory.cancel();
  }
}

