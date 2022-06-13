import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/players_stream_bloc.dart';
import 'package:word_game/models/models.dart';
import 'package:word_game/services/services.dart';
import 'package:word_game/styles/styles.dart';
import 'package:word_game/widgets/widget.dart';

class PlayersAvailable extends StatefulWidget {
  @override
  _PlayersAvailableState createState() => _PlayersAvailableState();
}

class _PlayersAvailableState extends State<PlayersAvailable> {
  final int _limit = 8;
  PlayersStream playersStream = PlayersStream();
  PlayersStreamBloc playersStreamBloc;
  final TextStyles style = TextStyles();
  final ScrollController scrollController = ScrollController();
  List<UserDetailsModel> players = [];
  DocumentSnapshot lastDoc;
  bool isLoading = true;
  bool isStreamStart = false;
  bool nothingToLoad = false;
  Widget playersWidget = Container();

  @override
  void initState() {
    playersStreamBloc = PlayersStreamBloc(playersStream: playersStream);
    playersStream.startPlayersStream(function: (QuerySnapshot snapshot) {
      if (isStreamStart) {
        for (DocumentChange doc in snapshot.docChanges) {
          UserDetailsModel player;
          if (doc.type == DocumentChangeType.added) {} //Do Something
          if (doc.type == DocumentChangeType.removed) {} //Do Something
          if (doc.type == DocumentChangeType.modified) {
            player = UserDetailsModel(data: doc.doc.data(), id: doc.doc.id);
            int playerPosition =
                players.indexWhere((user) => player.id == user.id);
            if (playerPosition >= 0) {
              if (player.status == 'in-lobby') {
                players.removeAt(playerPosition);
                players.insert(playerPosition, player);
              } else {
                players.removeAt(playerPosition);
                setPlayerPlaceHolder(isOnePlayer: true);
                playersStreamBloc..add(GeNewPlayerToInsert());
              }
            }
            log("Document of ${player?.id} is being ${doc.type}");
          }

          setState(() {});
        }
      } else {
        log("Stream players started...");
        isStreamStart = true;
      }
    });
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    playersStreamBloc..add(ClosePlayerStream());
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayersStreamBloc>(
      create: (context) => playersStreamBloc..add(StreamPlayersAvailable()),
      child: BlocListener<PlayersStreamBloc, PlayersStreamState>(
        listener: (context, state) {
          if ((state is PlayersStreamLoading) ||
              (state is NewPlayersIsLoading)) {
            setLoader(loading: true, state: state);
            setPlayerPlaceHolder(isOnePlayer: false);
          }

          if (state is PlayersStreamLoaded) {
            deletePlayerPlaceHolder(isOnePlayer: false);
            setInitialPlayers(players: state.players, lastDoc: state.doc);
            nothingToLoad = !(state.players.length >= _limit);
            setLoader(loading: false);
          }

          if (state is NewPlayersLoaded) {
            deletePlayerPlaceHolder(isOnePlayer: false);
            getNewPlayers(players: state.players, lastDoc: state.doc);
            nothingToLoad = !(state.players.length >= _limit);
            setLoader(loading: false);
          }

          if (state is FetchingNewPlayerDone) {
            deletePlayerPlaceHolder(isOnePlayer: true);
            if (state.player != null) players.add(state.player);
          }

          if (state is LoadPlayersError) {
            log("failed to load player");
          }
        },
        child: BlocBuilder<PlayersStreamBloc, PlayersStreamState>(
          builder: (context, state) {
            playersWidget = GridView(
              controller: scrollController,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: players
                  .map((player) => player == null
                      ? PlayerPlaceHolderCard()
                      : player.id == 'loader'
                          ? PlayerPlaceHolderCard()
                          : PlayerCard(
                              player: player,
                              isLoading: state is SendingInvitation &&
                                  state.playerID == player.id,
                              function: () async {
                                InvitationModel invitation =
                                    InvitationModel(data: {}, id: '');
                                invitation.senderID = "!fafas";
                                invitation.playerID = player.id;
                                playersStreamBloc
                                  ..add(SendInvitation(invitation: invitation));

                                log('inviting player ${player.inGameName}');
                              },
                            ))
                  .toList(),
            );

            if (state is LoadPlayersError)
              return LoadPlayerFailed(imageLocation: 'failed player');
            if (state is PlayersStreamLoaded) if (state.players.isEmpty)
              playersWidget = NoPlayersAvailable(imageLocation: 'no players');

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Players Available",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: style.primaryFontSize,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(child: playersWidget),
                ),
                state is! NewPlayersIsLoading
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: LinearProgressIndicator(
                          backgroundColor:
                              AppCrolor().secondaryDark.withAlpha(60),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppCrolor().secondary),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  setLoader({bool loading, PlayersStreamState state}) {
    isLoading = loading;
  }

  setInitialPlayers(
      {List<UserDetailsModel> players, DocumentSnapshot lastDoc}) {
    this.players = players;
    this.lastDoc = lastDoc;
  }

  getNewPlayers({List<UserDetailsModel> players, DocumentSnapshot lastDoc}) {
    this.players.addAll(players.toList());
    this.lastDoc = lastDoc;
  }

  setPlayerPlaceHolder({@required bool isOnePlayer}) {
    if (!isOnePlayer) {
      for (var p = 0; p < _limit; p++) {
        players.add(UserDetailsModel(data: {}, id: "loader"));
      }
    } else {
      players.add(UserDetailsModel(data: {}, id: "loader"));
    }
  }

  deletePlayerPlaceHolder({@required bool isOnePlayer}) {
    if (!isOnePlayer) {
      players.removeRange(players.length - _limit, players.length);
    } else {
      players.removeRange(players.length - 1, players.length);
    }
  }

  _scrollListener() {
    if (!isLoading && !nothingToLoad) {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          isLoading = true;
          setState(() {});
          playersStreamBloc..add(GetPaginatedPlayersAvailable());
        }
      }
    }
  }
}
