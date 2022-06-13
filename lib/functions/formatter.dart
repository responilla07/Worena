import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatter {

  dateMMddyyhhmma({@required Timestamp date}) {
    String lastMatchDate = "loading...";
    try {
      lastMatchDate =
          DateFormat("MM/dd/yy hh:mm a").format(date.toDate());
    } catch (e) {}
    return lastMatchDate;
  }

  badgeCount({@required int num}) {
    String count = "...";

    if (num >= 100) {
      count = '99+';
    } else if (num < 0){
      count = '0';
    } else if (num == 0){
      count = '...';
    } else {
      count = '$num';
    }

    return count;
  }
  
}