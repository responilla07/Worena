part of 'match_history_bloc.dart';

abstract class MatchHistoryEvent extends Equatable {
  const MatchHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchInitialMatchHistory extends MatchHistoryEvent {}
class FetchAnotherMatchHistory extends MatchHistoryEvent {}