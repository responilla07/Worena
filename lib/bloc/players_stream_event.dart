part of 'players_stream_bloc.dart';

abstract class PlayersStreamEvent extends Equatable {
  const PlayersStreamEvent();

  @override
  List<Object> get props => [];
}

class StreamPlayersAvailable extends PlayersStreamEvent {
  const StreamPlayersAvailable();

  @override
  List<Object> get props => [];

  String toString() => 'StreamInitialPlayersAvailable { }';
}

class GetPaginatedPlayersAvailable extends PlayersStreamEvent {
  const GetPaginatedPlayersAvailable();

  @override
  List<Object> get props => [];

  String toString() => 'GetPaginatedPlayersAvailable { }';
}

class GeNewPlayerToInsert extends PlayersStreamEvent {
  const GeNewPlayerToInsert();

  @override
  List<Object> get props => [];

  String toString() => 'GeNewPlayerToInsert { }';
}

class SendInvitation extends PlayersStreamEvent {
  final InvitationModel invitation;
  const SendInvitation({
    @required this.invitation
  });

  @override
  List<Object> get props => [
        invitation,
      ];

  String toString() =>
      'SendInvitation { from senderID: ${invitation.senderID} to playerID: ${invitation.playerID} }';
}

class ClosePlayerStream extends PlayersStreamEvent {
  const ClosePlayerStream();

  @override
  List<Object> get props => [];

  String toString() => 'ClosePlayerStream { }';
}
