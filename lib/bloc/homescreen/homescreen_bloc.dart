import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'homescreen_event.dart';
part 'homescreen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(const HomeScreenState()) {
    on<ToggleSideBar>(_onToggleSideBar);
    on<ToggleHistory>(_onToggleHistory);
  }
  void _onToggleSideBar(ToggleSideBar event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(isSideBarOpen: !state.isSideBarOpen));
  }

  void _onToggleHistory(ToggleHistory event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(isHistoryOpen: !state.isHistoryOpen));
  }
}
