import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'homepage_popup_state.dart';

class ThreedotCubit extends Cubit<ThreedotState> {
  ThreedotCubit() : super(const ThreedotState());

  void toggleHistory() {
    emit(state.copyWith(isHistoryOpen: !state.isHistoryOpen));
  }
}
