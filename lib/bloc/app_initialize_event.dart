part of 'app_initialize_bloc.dart';

abstract class AppInitializeEvent extends Equatable {
  const AppInitializeEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AppInitializeEvent {}
class AppUserLogin extends AppInitializeEvent {}
class AppUserLogout extends AppInitializeEvent {}
