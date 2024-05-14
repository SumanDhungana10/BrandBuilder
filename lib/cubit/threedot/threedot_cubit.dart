import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'threedot_state.dart';

class ThreedotCubit extends Cubit<ThreedotState> {
  ThreedotCubit() : super(const ThreedotState());

  void toggleIncognitoMode() {
    emit(state.copyWith(isIncognitoMode: !state.isIncognitoMode));
  }
}
