import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:word_game/functions/functions.dart';
import 'package:word_game/models/models.dart';
import 'package:word_game/services/services.dart';
import 'package:word_game/styles/styles.dart';

class UserCardDisplay extends StatefulWidget {
  @override
  _UserCardDisplayState createState() => _UserCardDisplayState();
}

class _UserCardDisplayState extends State<UserCardDisplay> {
  final AppCrolor appColor = AppCrolor();
  final TextStyles style = TextStyles();
  final Account account = Account();
  final Formatter format = Formatter();
  MatchDetailsModel lastMatch;

  @override
  void initState() {
    super.initState();
    accountDetails.addListener(accountListener);
    Future.delayed(Duration(seconds: 1), () async {
      account.startStreamingAccount(function: (UserDetailsModel accnt) {
        lastMatch = MatchDetailsModel(
            data: accnt.matchHistory.setMatch(),
            id: accnt.matchHistory.matchId);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    accountDetails.removeListener(accountListener);
    account.closeStream();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      // color: Color(0xfff0f4f7),
      elevation: 8.5,
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: ContainerDecoration().boxDecoration,
                  child: CircleAvatar(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: accountDetails.value.picURI,
                        fit: BoxFit.cover,
                        height: 150,
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
                    radius: 25,
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        accountDetails.value.inGameName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: appColor.secondaryDark,
                          fontFamily: style.primaryFontFamily,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Last played: ${format.dateMMddyyhhmma(date: accountDetails.value.matchHistory.date['ended'])}",
                              // text: "Last played: ${accountDetails.value.matchHistory.date['ended']}",
                              style: TextStyle(
                                fontSize: 14,
                                color: appColor.grey,
                                fontFamily: style.primaryFontFamily,
                              ),
                            ),
                            TextSpan(
                              text: lastMatch == null
                                  ? ""
                                  : lastMatch.id == ""
                                      ? ""
                                      : currentUserWin()
                                          ? " (WIN)"
                                          : " (LOSE)",
                              style: TextStyle(
                                fontSize: 14,
                                color: lastMatch == null
                                    ? null
                                    : currentUserWin()
                                        ? appColor.green
                                        : appColor.red,
                                fontFamily: style.primaryFontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Divider(thickness: 2),
            cardIcons(),
          ],
        ),
      ),
    );
  }

  Widget cardIcons() {
    List<Widget> children = [];
    Map<String, dynamic> widgets = {
      "Achievements": {
        "function": () {
          log("Achievements clicked");
        },
        "icon": "assets/icons/trophy.png",
        "badge": format.badgeCount(num: accountDetails.value.badge.trophy),
      },
      "Invites": {
        "function": () {
          log("Invites clicked");
        },
        "icon": "assets/icons/invite.png",
        "badge": format.badgeCount(num: accountDetails.value.badge.invites),
      },
      "Inbox": {
        "function": () {
          log("Inbox clicked");
        },
        "icon": "assets/icons/inbox.png",
        "badge": format.badgeCount(num: accountDetails.value.badge.inbox),
      },
    };

    widgets.forEach((text, v) {
      children.add(GestureDetector(
        onTap: v['function'],
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
              child: Container(
                decoration: ContainerDecoration().boxDecoration,
                child: Image(
                  height: 40,
                  fit: BoxFit.cover,
                  image: AssetImage(v['icon']),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: appColor.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: BoxConstraints(minWidth: 22, minHeight: 22),
                child: Text(
                  v['badge'].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ));
    });
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }

  accountListener() {
    setState(() {});
  }

  currentUserWin() {
    bool status;
    if (accountDetails.value.id == lastMatch.winnerID) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }
}
