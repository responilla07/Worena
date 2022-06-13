part of 'match_history_bloc.dart';

abstract class MatchHistoryState extends Equatable {
  const MatchHistoryState();

  @override
  List<Object> get props => [];
}

class MatchHistoryInitial extends MatchHistoryState {}

class FetchingMatchHistory extends MatchHistoryState {}

class FetchInitialMatchHistoryDone extends MatchHistoryState {}

class FetchingAnotherMatchHistory extends MatchHistoryState {}

class FetchAnotherMatchHistoryDone extends MatchHistoryState {}
