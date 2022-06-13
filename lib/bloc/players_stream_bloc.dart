import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:word_game/models/models.dart';
import 'package:word_game/services/services.dart';

part 'players_stream_event.dart';
part 'players_stream_state.dart';

class PlayersStreamBloc extends Bloc<PlayersStreamEvent, PlayersStreamState> {
  final PlayersStream playersStream;
  PlayersStreamBloc({@required this.playersStream})
      : assert(playersStream != null),
        super(PlayersStreamInitial());

  @override
  Stream<PlayersStreamState> mapEventToState(
    PlayersStreamEvent event,
  ) async* {
    // try {
      if (event is StreamPlayersAvailable) {
        yield PlayersStreamLoading();
        List<UserDetailsModel> players = await playersStream.getInitialPlayers();

        yield PlayersStreamLoaded(players: players, doc: playersStream.lastDoc);
      }

      if (event is GetPaginatedPlayersAvailable) {
        yield NewPlayersIsLoading();
        List<UserDetailsModel> players = await playersStream.geNewPlayers();

        yield NewPlayersLoaded(players: players, doc: playersStream.lastDoc);
      }
      if (event is GeNewPlayerToInsert) {
        yield FetchingNewPlayer();
        UserDetailsModel player = await playersStream.geNewPlayerToInsert();

        yield FetchingNewPlayerDone(player: player, doc: playersStream.lastDoc);
      }

      if (event is SendInvitation) {
        yield SendingInvitation(playerID: event.invitation.playerID);
        String message = await playersStream.sendInvitation(invitation: event.invitation);

        yield InvitationSent(message: message);
      }

      if (event is ClosePlayerStream) {
        playersStream.closePlayersStream();
      }
    // } catch (e) {
    //   log('Error: ' + e.toString());
    //   yield LoadPlayersError(message: e.toString());
    // }
  }
}
