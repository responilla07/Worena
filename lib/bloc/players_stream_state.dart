part of 'players_stream_bloc.dart';

abstract class PlayersStreamState extends Equatable {
  const PlayersStreamState();

  @override
  List<Object> get props => [];
}

class PlayersStreamInitial extends PlayersStreamState {}

class PlayersStreamLoading extends PlayersStreamState {}

class NewPlayersIsLoading extends PlayersStreamState {}

class FetchingNewPlayer extends PlayersStreamState {}

class SendingInvitation extends PlayersStreamState {
  final String playerID;

  const SendingInvitation({
    @required this.playerID,
  });

  @override
  List<Object> get props => [
        playerID,
      ];

  String toString() => 'SendingInvitation {playerID: $playerID';
}

class InvitationSent extends PlayersStreamState {
  final String message;

  const InvitationSent({
    @required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];

  String toString() => 'InvitationSent {message: $message';
}

class LoadPlayersError extends PlayersStreamState {
  final String message;

  const LoadPlayersError({
    @required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];

  String toString() => 'LoadPlayersError {message: $message';
}

class PlayersStreamLoaded extends PlayersStreamState {
  final List<UserDetailsModel> players;
  final DocumentSnapshot doc;

  const PlayersStreamLoaded({
    @required this.players,
    @required this.doc,
  });

  @override
  List<Object> get props => [
        players,
        doc,
      ];

  String toString() => 'PlayersStreamLoaded {Total players: ${players.length}';
}

class NewPlayersLoaded extends PlayersStreamState {
  final List<UserDetailsModel> players;
  final DocumentSnapshot doc;

  const NewPlayersLoaded({
    @required this.players,
    @required this.doc,
  });

  @override
  List<Object> get props => [
        players,
        doc,
      ];

  String toString() => 'NewPlayersLoaded {Total players: ${players.length}';
}

class FetchingNewPlayerDone extends PlayersStreamState {
  final UserDetailsModel player;
  final DocumentSnapshot doc;

  const FetchingNewPlayerDone({
    @required this.player,
    @required this.doc,
  });

  @override
  List<Object> get props => [
        player,
        doc,
      ];

  String toString() => 'NewPlayersLoaded {Player: ${player.id}';
}
