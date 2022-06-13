import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:word_game/functions/word_generator.dart';
import 'package:word_game/services/services.dart';
import 'package:word_game/styles/colors.dart';
import 'package:word_game/widgets/input_field.dart';

class GamePage extends StatefulWidget {
  GamePage({
    this.title,
  });
  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  var appColor = AppCrolor();
  var word = GenerateWord();
  var wordStream = WordStream();
  var text = "";
  
  @override
  void initState() {
    wordStream.startWordStream(function: (QuerySnapshot snapshot){
      Map<dynamic, dynamic> data = snapshot.docs[0].data();
      print(data);
      text = word.guestWord(data["word"]);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 250,
          left: 16,
          right: 16,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 8.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: appColor.color("e1e3e8"),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        constraints: BoxConstraints(
                          maxHeight: 120.0,
                        ),
                        child: InputField(),
                      ),
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 36.0,
                        color: appColor.color("8abfff"),
                      ),
                      onPressed: () async {
                        log("send my answer");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
