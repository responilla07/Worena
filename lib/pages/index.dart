import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/bloc.dart';
import 'package:word_game/bloc/find_match_bloc.dart';
import 'package:word_game/components/components.dart';
import 'package:word_game/functions/log.dart';
import 'package:word_game/models/models.dart';
import 'package:word_game/services/services.dart';
import 'package:word_game/styles/styles.dart';
import 'package:word_game/widgets/place_holder.dart';
import 'package:word_game/widgets/widget.dart';

class Index extends StatefulWidget {
  Index({
    this.title,
  });
  final String title;

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final AppCrolor appColor = AppCrolor();
  final TextStyles style = TextStyles();
  StartMatchMaking matchMaking = StartMatchMaking();
  FindMatchBloc matchGame;
  bool findingMatch = false;
  bool matchedDialogShoudShow = false;

  @override
  void initState() {
    matchGame = FindMatchBloc(matchMaking: matchMaking);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = Size(context);
    var bot = size.height() / 1.3;
    var top = size.height() - bot + 110;
    return Container(
      width: size.width(),
      height: size.height(),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Stack(
                children: [
                  UserCardDisplay(),
                  Positioned(
                    top: 12,
                    right: 14,
                    child: GestureDetector(
                      onTap: () async {
                        // AppInitializeLoginPage

                        // log(id);
                        accountDetails.value =
                            UserDetailsModel(data: {}, id: "");
                        BlocProvider.of<AppInitializeBloc>(context)
                            .add(AppUserLogout());
                      },
                      child: Container(
                        decoration: ContainerDecoration().boxDecoration,
                        child: Image(
                          height: 25,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/icons/settings.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 190,
              bottom: 76,
              left: 14,
              right: 14,
              child: MatchHistory(),
            ),
            Positioned(
              bottom: 16,
              left: 14,
              right: 14,
              child: BlocProvider<FindMatchBloc>(
                create: (provcontext) =>
                    matchGame..add(LoadInitialMatchMaking()),
                child: BlocBuilder<FindMatchBloc, FindMatchState>(
                  builder: (context, state) {
                    matchMakingStatus(state);

                    if (state is MatchContinueQueuing) {
                      matchedDialogShoudShow = true;
                      matchMaking.stopWaitingForMatchedPlayer();
                      matchMaking.startWaitingForMatchedPlayer(
                          function: (MatchDetailsModel match) {
                          logData(
                              data:
                                  "Match found! vs ${match.players.playerTwo}? Match ID: ${match.id}");
                        if (match.players.playerTwo != "" &&
                            match.status == "matched" &&
                            matchedDialogShoudShow) {
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => showPromptDialog(context));
                          setState(() {});
                        }
                        if (match.id == 'not_found') {
                          matchGame..add(DeclineMatch());
                        }
                      });
                    }

                    if (state is MatchFound) {
                      WidgetsBinding.instance.addPostFrameCallback(
                          (_) => showPromptDialog(context));
                    }

                    return CustomButton(
                      function: findingMatch
                          ? null
                          : () async {
                              // showPromptDialog(context);
                              matchGame
                                ..add(FindMatchPlayer(
                                    points: accountDetails.value.mmrPoints));
                            },
                      text: findingMatch
                          ? "Finding match player..."
                          : "FIND MATCH",
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showPromptDialog(context) {
    matchedDialogShoudShow = false;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: CustomDialog(
          body:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
          title: "Match Found",
          assets: 'assets/maps/usa.png',
          btnCancelText: 'decline',
          cancelFunction: () {
            matchGame..add(DeclineMatch());
            Navigator.of(context).pop();
          },
          btnAcceptText: 'ACCEPT',
          acceptFunction: () {
            matchGame..add(AcceptMatch());
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void matchMakingStatus(FindMatchState state) {
    if (state is! MatchAccepted || state is! MatchMakingStopped) {
      if (state is InitialMatchMakingLoaded || state is MatchDeclined) {
        findingMatch = false;
      } else {
        findingMatch = true;
      }
    } else {
      findingMatch = false;
    }
  }
}
