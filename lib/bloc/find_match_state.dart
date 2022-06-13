part of 'find_match_bloc.dart';

abstract class FindMatchState extends Equatable {
  const FindMatchState();

  @override
  List<Object> get props => [];
}

class FindMatchInitial extends FindMatchState {}

class InitialMatchMakingLoaded extends FindMatchState {}

class MatchMakingStarted extends FindMatchState {}

class MatchContinueQueuing extends FindMatchState {}

class MatchCreated extends FindMatchState {
  final String matchID;

  const MatchCreated({
    @required this.matchID,
  });

  @override
  List<Object> get props => [
        matchID,
      ];

  String toString() => 'MatchFound { Match ID: $matchID';
}

class MatchFound extends FindMatchState {
  String toString() => 'MatchFound ';
}

class MatchAccepted extends FindMatchState {
  final String matchID;

  const MatchAccepted({
    @required this.matchID,
  });

  @override
  List<Object> get props => [
        matchID,
      ];

  String toString() => 'MatchAccepted { Match ID: $matchID';
}

class MatchDeclined extends FindMatchState {
  String toString() => 'MatchDeclined';
}

class MatchMakingStopped extends FindMatchState {
  final String matchID;

  const MatchMakingStopped({
    @required this.matchID,
  });

  @override
  List<Object> get props => [
        matchID,
      ];

  String toString() => 'MatchMakingStopped { Match ID: $matchID';
}
