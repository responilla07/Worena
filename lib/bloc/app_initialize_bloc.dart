import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:word_game/services/services.dart';

part 'app_initialize_event.dart';
part 'app_initialize_state.dart';

class AppInitializeBloc extends Bloc<AppInitializeEvent, AppInitializeState> {
  AppInitializeBloc() : super(AppInitializeInitial());

  @override
  Stream<AppInitializeState> mapEventToState(
    AppInitializeEvent event,
  ) async* {
    if (event is AppStarted) {
      yield AppInitializeLoading();
      // await Future.delayed(Duration(seconds: 5), () {}); // TODO remove after testing
      if (FirebaseAuth.instance.currentUser != null) {
        yield AppInitializeHomePage();
      } else {
        yield AppInitializeLoginPage();
      }
      return;
    }
    if (event is AppUserLogin) {
      if (FirebaseAuth.instance.currentUser != null) {
        yield AppInitializeHomePage();
      } else {
        yield AppInitializeLoginPage();
      }
      return;
    }
    if (event is AppUserLogout) {
      Authentication().logoutAuthUser();
      yield AppInitializeLoginPage();
      return;
    }
  }
}
