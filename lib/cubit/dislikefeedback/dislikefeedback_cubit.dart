import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dislikefeedback_state.dart';

class DislikefeedbackCubit extends Cubit<DislikefeedbackState> {
  DislikefeedbackCubit() : super(const DislikefeedbackState());

  void disLikeFeedback(int index) {
    final newDisLikedIndex = {...state.disLikedIndex};
    newDisLikedIndex[index] = true;
    emit(state.copyWith(disLikedIndex: newDisLikedIndex));
    print(state.disLikedIndex);
  }

  void closeDisLikeFeedback(int index) {
    final newDisLikedIndex = {...state.disLikedIndex};
    newDisLikedIndex.remove(index);
    emit(state.copyWith(disLikedIndex: newDisLikedIndex));
    print(state.disLikedIndex);
  }
}
