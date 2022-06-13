part of 'app_initialize_bloc.dart';

abstract class AppInitializeState extends Equatable {
  const AppInitializeState();
  
  @override
  List<Object> get props => [];
}

class AppInitializeInitial extends AppInitializeState {}
class AppInitializeLoading extends AppInitializeState {}
class AppInitializeHomePage extends AppInitializeState {}
class AppInitializeLoginPage extends AppInitializeState {}