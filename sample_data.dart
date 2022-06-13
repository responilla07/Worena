import 'package:cloud_firestore/cloud_firestore.dart';

asd() async {
  var batch = FirebaseFirestore.instance.batch();
  Map<String, dynamic> data = {
    's9': {
      'game_record': {'lose': 33, 'win': 44},
      'in_game_name': 'hAo'
    },
    's10': {
      'game_record': {'lose': 33, 'win': 28},
      'in_game_name': 'ChinChin'
    },
    's11': {
      'game_record': {'lose': 88, 'win': 28},
      'in_game_name': 'Jake123'
    },
    's12': {
      'game_record': {'lose': 11, 'win': 57},
      'in_game_name': 'm@e23'
    },
    's13': {
      'game_record': {'lose': 12, 'win': 0},
      'in_game_name': 'sheena'
    },
    's14': {
      'game_record': {'lose': 581, 'win': 111},
      'in_game_name': 'j3r0me'
    },
    's15': {
      'game_record': {'lose': 66, 'win': 126},
      'in_game_name': 'xXKillerxX'
    },
    's16': {
      'game_record': {'lose': 2, 'win': 55},
      'in_game_name': '-=James=-'
    },
    's17': {
      'game_record': {'lose': 55, 'win': 132},
      'in_game_name': 'Markeyyyy'
    },
    's18': {
      'game_record': {'lose': 752, 'win': 501},
      'in_game_name': 'Alodia'
    },
    's19': {
      'game_record': {'lose': 88, 'win': 150},
      'in_game_name': 'Razziieee'
    },
    's20': {
      'game_record': {'lose': 69, 'win': 88},
      'in_game_name': '69BEBE69'
    },
    's21': {
      'game_record': {'lose': 45, 'win': 28},
      'in_game_name': 'lizzyyy'
    },
  };
  data.forEach((key, value) {
    batch.set(FirebaseFirestore.instance.collection('Users').doc(key), value);
  });
  await batch.commit();
}

update() async {
  await FirebaseFirestore.instance.collection('Users').get().then((docs) async {
    var batch = FirebaseFirestore.instance.batch();
    docs.docs.forEach((doc) {
      batch.update(
          FirebaseFirestore.instance.collection('Users').doc(doc.id), {});
    });
    await batch.commit();
  });
}

transaction() {
  // final DocumentReference inquiryRef = usersCollection.doc(invitation.playerID);

  // try {
  //   FirebaseFirestore.instance.runTransaction((Transaction tx) async {
  //     DocumentSnapshot postSnapshot = await tx.get(inquiryRef);
  //     if (postSnapshot.exists) {
  //     } else {
  //       throw "Document Error";
  //     }
  //   });
  // } catch (e) {

  // }
}

createUserDetails() {
  FirebaseFirestore.instance
      .collection('Users')
      .doc('8AtGpHRUECfWENONAeRBzXSJviv2')
      .set({
    'game_record': {'lose': 69, 'win': 88},
    'in_game_name': 'fafa.Shukin',
    'invitations': [],
    'status': 'in-lobby',
    'picURI': '',
    'badge': {
      'trophy': 8,
      'invites': 60,
      'inbox': 101,
    },
    'last_match': {
      'date': {
        'ended': FieldValue.serverTimestamp(),
      },
      'status': 'game_finish',
      'winner_id': '8AtGpHRUECfWENONAeRBzXSJviv2',
    }
  });
}

createMatchHistory() {
  // var id = Uuid().v4();
  // var id1 = Uuid().v4();
  // var id2 = Uuid().v4();
  // var id3 = Uuid().v4();
  // var id4 = Uuid().v4();
  // var batch = FirebaseFirestore.instance.batch();
  // MatchDetailsModel matchDetailsModel = MatchDetailsModel(data: {} ,id: "");
  // matchDetailsModel.matchMap = 'assets/maps/canada.png';
  // matchDetailsModel.players.playerOne = FirebaseAuth.instance.currentUser.uid;
  // matchDetailsModel.matchId = id;
  // MatchDetailsModel matchDetailsModel1 = MatchDetailsModel(data: {} ,id: "");
  // matchDetailsModel1.matchMap = 'assets/maps/usa.png';
  // matchDetailsModel1.players.playerOne = FirebaseAuth.instance.currentUser.uid;
  // matchDetailsModel1.matchId = id;
  // MatchDetailsModel matchDetailsModel2 = MatchDetailsModel(data: {} ,id: "");
  // matchDetailsModel2.matchMap = 'assets/maps/singapore.png';
  // matchDetailsModel2.players.playerOne = FirebaseAuth.instance.currentUser.uid;
  // matchDetailsModel2.matchId = id;
  // MatchDetailsModel matchDetailsModel3 = MatchDetailsModel(data: {} ,id: "");
  // matchDetailsModel3.matchMap = 'assets/maps/china.png';
  // matchDetailsModel3.players.playerOne = FirebaseAuth.instance.currentUser.uid;
  // matchDetailsModel3.matchId = id;
  // MatchDetailsModel matchDetailsModel4 = MatchDetailsModel(data: {} ,id: "");
  // matchDetailsModel4.matchMap = 'assets/maps/usa.png';
  // matchDetailsModel4.players.playerOne = FirebaseAuth.instance.currentUser.uid;
  // matchDetailsModel4.matchId = id;

  // batch.set(FirebaseFirestore.instance.collection('Users').doc('8AtGpHRUECfWENONAeRBzXSJviv2').collection('MatchHistory').doc(id), matchDetailsModel.setMatch());
  // batch.set(FirebaseFirestore.instance.collection('Matches').doc(id), matchDetailsModel.setMatch());
  // batch.set(FirebaseFirestore.instance.collection('Users').doc('8AtGpHRUECfWENONAeRBzXSJviv2').collection('MatchHistory').doc(id1), matchDetailsModel1.setMatch());
  // batch.set(FirebaseFirestore.instance.collection('Matches').doc(id1), matchDetailsModel1.setMatch());
  // batch.set(FirebaseFirestore.instance.collection('Users').doc('8AtGpHRUECfWENONAeRBzXSJviv2').collection('MatchHistory').doc(id2), matchDetailsModel2.setMatch());
  // batch.set(FirebaseFirestore.instance.collection('Matches').doc(id2), matchDetailsModel2.setMatch());
  // batch.set(FirebaseFirestore.instance.collection('Users').doc('8AtGpHRUECfWENONAeRBzXSJviv2').collection('MatchHistory').doc(id3), matchDetailsModel3.setMatch());
  // batch.set(FirebaseFirestore.instance.collection('Matches').doc(id3), matchDetailsModel3.setMatch());
  // batch.set(FirebaseFirestore.instance.collection('Users').doc('8AtGpHRUECfWENONAeRBzXSJviv2').collection('MatchHistory').doc(id4), matchDetailsModel4.setMatch());
  // batch.set(FirebaseFirestore.instance.collection('Matches').doc(id4), matchDetailsModel4.setMatch());

  // await batch.commit();
}

updateMatch() {
  // MatchDetailsModel match = MatchDetailsModel(data: {}, id: "");
  // match.players.playerTwo = "agila";
  // await FirebaseFirestore.instance.collection('Users').doc('8AtGpHRUECfWENONAeRBzXSJviv2').collection('MatchHistory').limit(21).get().then((docs) async {
  //   var batch = FirebaseFirestore.instance.batch();
  //   var winnerID = "";
  //   bool a = false;
  //   docs.docs.forEach((doc) {

  //     if(a){
  //       winnerID = "agila";
  //     } else {
  //       winnerID = "8AtGpHRUECfWENONAeRBzXSJviv2";
  //     }
  //     batch.update(FirebaseFirestore.instance.collection('Users').doc('8AtGpHRUECfWENONAeRBzXSJviv2').collection('MatchHistory').doc(doc.id),{
  //       'winner_id' :winnerID
  //     });
  //     batch.update(FirebaseFirestore.instance.collection('Matches').doc(doc.id), {
  //       'winner_id' :winnerID
  //     });

  //     if(a){
  //       a = false;
  //     } else {
  //       a = true;
  //     }
  //   });
  //   await batch.commit();
  // });
}

updatePlayerOne() {
  FirebaseFirestore.instance.collection('Matches').get().then((q) {
    var _batch = FirebaseFirestore.instance.batch();
    q.docs.forEach((doc) {
      _batch.update(
          FirebaseFirestore.instance.collection('Matches').doc(doc.id),
          {'players.player_one_id': 'm17kbqh3Lfaxr8dERhrBTdAGHqr1'});
    });
    _batch.commit();
  });
}
