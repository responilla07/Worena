import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:word_game/functions/functions.dart';
import 'package:word_game/models/models.dart';
import 'package:word_game/styles/styles.dart';

class PlayerCard extends StatefulWidget {
  PlayerCard({
    @required this.player,
    @required this.function,
    @required this.isLoading,
  });

  final UserDetailsModel player;
  final Function function;
  final bool isLoading;

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  final AppCrolor appColor = AppCrolor();
  final TextStyles style = TextStyles();
  ComputeWinRate winrate;

  @override
  void initState() {
    winrate = ComputeWinRate(
        lose: widget.player.gameRecord.lose, win: widget.player.gameRecord.win);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Color(0xfff0f4f7),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Container(
                  decoration: ContainerDecoration().boxDecoration,
                  child: CircleAvatar(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.player.picURI,
                        fit: BoxFit.cover,
                        height: 120,
                        placeholder: (context, url) => Image(
                          image: AssetImage('assets/avatar/default.png'),
                          height: 150,
                        ),
                        errorWidget: (context, url, error) => Image(
                          image: AssetImage('assets/avatar/default.png'),
                          height: 150,
                        ),
                      ),
                    ),
                    radius: 20,
                  ),
                ),
                SizedBox(height: 8),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.player.inGameName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: style.defaultFontSize,
                      color: appColor.secondaryDark,
                      fontFamily: style.primaryFontFamily,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Win rate " + winrate.computeWinrate(),
                    style: TextStyle(
                      fontSize: 14,
                      color: appColor.grey,
                      fontFamily: style.primaryFontFamily,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: appColor.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(1.0, 1.0),
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    // child: Text('..'),
                    child: widget.isLoading
                        ? Text(
                            "Inviting...", //style: textStyle,
                          )
                        : Text(
                            "Invite to play", //style: textStyle,
                          ),
                  )),
              onTap: widget.isLoading ? null : widget.function,
            ),
          ],
        ),
      ),
    );
  }
}
