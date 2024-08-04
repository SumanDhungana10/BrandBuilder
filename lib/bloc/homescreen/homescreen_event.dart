part of 'homescreen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class ToggleSideBar extends HomeScreenEvent {}

class ToggleHistory extends HomeScreenEvent {}
