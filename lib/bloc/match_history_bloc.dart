import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:word_game/services/services.dart';

part 'match_history_event.dart';
part 'match_history_state.dart';

class MatchHistoryBloc extends Bloc<MatchHistoryEvent, MatchHistoryState> {
  final StreamMatchHistory matchHistory;
  MatchHistoryBloc({@required this.matchHistory})
      : assert(matchHistory != null),
        super(MatchHistoryInitial());

  @override
  Stream<MatchHistoryState> mapEventToState(
    MatchHistoryEvent event,
  ) async* {

    if (event is FetchInitialMatchHistory) {
      
    }
    
    if (event is FetchAnotherMatchHistory) {
      
    }
  }
}
