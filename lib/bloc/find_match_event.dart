part of 'find_match_bloc.dart';

abstract class FindMatchEvent extends Equatable {
  const FindMatchEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialMatchMaking extends FindMatchEvent {}

class FindMatchPlayer extends FindMatchEvent {
  final int points;
  const FindMatchPlayer({@required this.points});

  @override
  List<Object> get props => [
        points,
      ];

  String toString() => 'FindMatchPlayer {My Points: $points}';
}

class AcceptMatch extends FindMatchEvent {}

class DeclineMatch extends FindMatchEvent {}

class StopMatchMaking extends FindMatchEvent {
  final String gameID;
  const StopMatchMaking({@required this.gameID});

  @override
  List<Object> get props => [
        gameID,
      ];

  String toString() => 'StopMatchMaking { Game ID: $gameID}';
}
