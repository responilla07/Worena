import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/models/models.dart';
import 'package:word_game/services/services.dart';
import 'package:word_game/styles/styles.dart';
import 'package:word_game/bloc/bloc.dart';

class MatchHistory extends StatefulWidget {
  const MatchHistory();

  @override
  _MatchHistoryState createState() => _MatchHistoryState();
}

class _MatchHistoryState extends State<MatchHistory> {
  final AppCrolor appColor = AppCrolor();
  List<MatchDetailsModel> players = [];
  StreamMatchHistory matchHistory = StreamMatchHistory();
  MatchHistoryBloc matchHistoryBloc;

  @override
  void initState() {
    matchHistoryBloc = MatchHistoryBloc(matchHistory: matchHistory);
    matchHistory.startMatchHistoryStream(
        function: (QuerySnapshot querySnapshot) {
      log(querySnapshot.docs.length.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    matchHistory?.closeMatchHistoryStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8.5,
      child: Stack(
        children: [
          listOfMatches(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(32, 0, 32, 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(120),
                    bottomRight: Radius.circular(120),
                  ),
                ),
                child: Text(
                  "MATCH HISTORY",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listOfMatches() {
    return BlocProvider<MatchHistoryBloc>(
      create: (context) => matchHistoryBloc..add(FetchInitialMatchHistory()),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: 12,
        itemBuilder: (a, e) {
          return Padding(
            padding: e == 0
                ? EdgeInsets.only(top: 32, bottom: 8)
                : EdgeInsets.symmetric(vertical: 8),
            child: Container(
              child: Container(
                child: Stack(
                  children: [
                    Positioned(
                      top: -5,
                      bottom: -5,
                      right: -5,
                      child: ClipOval(
                        child: Image(
                          image: AssetImage('assets/maps/canada.png'),
                          fit: BoxFit.cover,
                          width: 100,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blue.withOpacity(.2),
                            Colors.green.withOpacity(.5),
                          ],
                        ),
                      )),
                    ),
                    Positioned(
                      top: 2,
                      left: 1,
                      bottom: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "VICTORY",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            "13-6",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "VICTORY",
                            style: TextStyle(
                              color: appColor.secondaryDark,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            "13-6",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "6",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          // fontWeight:
                                          //     FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "▲",
                                        style: TextStyle(
                                          color: Colors.green[800],
                                        ),
                                      ),
                                      TextSpan(
                                        text: "▼",
                                        style: TextStyle(
                                          color: Colors.red[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text("06/28/21")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(.4),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
