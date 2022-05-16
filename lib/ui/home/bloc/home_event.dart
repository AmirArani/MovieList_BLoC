part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeRefresh extends HomeEvent {
  @override
  List<Object?> get props => [];
}
