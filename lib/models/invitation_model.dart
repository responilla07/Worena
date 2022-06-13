import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InvitationModel {
  String id;
  String senderID;
  String playerID;
  bool isSeen;
  String status;

  InvitationModel({@required Map<dynamic, dynamic> data, @required String id}) {
    this.id = id;
    this.senderID = data['sender_id'] ?? "";
    this.playerID = data['player_id'] ?? "";
    this.status = data['status'] ?? "Pending";
    this.isSeen = data['is_seen'] ?? false;
  }

  Map<String, dynamic> setInvitation() {
    return {
      'sender_id': this.senderID,
      'player_id': this.playerID,
      'status': this.status,
      'is_seen': this.isSeen,
      'date': {
        'created': FieldValue.serverTimestamp(),
      }
    };
  }

  Map<String, dynamic> seenInvitation() {
    return {
      'is_seen': true,
      'date.seen': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> acceptInvitation() {
    return {
      'status': "Accepted",
      'date.accepted': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> declineInvitation() {
    return {
      'status': "Declined",
      'date.declined': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> expiredInvitation() {
    return {
      'status': "Expired",
      'date.expired': FieldValue.serverTimestamp(),
    };
  }
}
