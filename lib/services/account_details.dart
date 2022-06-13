import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:word_game/models/models.dart';

ValueNotifier<UserDetailsModel> accountDetails = ValueNotifier<UserDetailsModel>(UserDetailsModel(data: {}, id: ""));

class Account {
  var usersCollection = FirebaseFirestore.instance.collection('Users');
  User user = FirebaseAuth.instance.currentUser;
  StreamSubscription<DocumentSnapshot> streamAccount;

  startStreamingAccount({@required Function function}) async {
    streamAccount = usersCollection.doc(user.uid).snapshots().listen((document) {
      accountDetails.value = UserDetailsModel(data: document.data(), id: document.id);
      function(accountDetails.value);
    });
  }

  closeStream(){
    streamAccount.cancel();
  }
}
