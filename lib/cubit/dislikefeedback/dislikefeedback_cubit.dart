
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dislikefeedback_state.dart';

class DislikefeedbackCubit extends Cubit<DislikefeedbackState> {
  DislikefeedbackCubit() : super(const DislikefeedbackState());

  void disLikeFeedback(int index) {
    final newDisLikedIndex = {...state.disLikedIndex};
    newDisLikedIndex[index] = true;
    emit(state.copyWith(disLikedIndex: newDisLikedIndex));
  }

  void closeDisLikeFeedback(int index) {
    final newDisLikedIndex = {...state.disLikedIndex};
    newDisLikedIndex.remove(index);
    emit(state.copyWith(disLikedIndex: newDisLikedIndex));
  }

  void regenerateFeedBack(int index) {
    final newRegeneratedIndex = {...state.regeneratedIndex};
    newRegeneratedIndex[index] = true;
    emit(state.copyWith(regeneratedIndex: newRegeneratedIndex));
  }

  void closeRegenerateFeedBack(int index) {
    final newRegeneratedIndex = {...state.regeneratedIndex};
    newRegeneratedIndex[index] = false;
    emit(state.copyWith(regeneratedIndex: newRegeneratedIndex));
  }

  void showThankYouMessage(int index) {
    final newShowThankYouMessage = {...state.showThankYouMessage};
    newShowThankYouMessage[index] = true;
    emit(state.copyWith(showThankYouMessage: newShowThankYouMessage));
    print(state.showThankYouMessage);
  }

  void closeThankYouMessage(int index) {
    final newShowThankYouMessage = {...state.showThankYouMessage};
    newShowThankYouMessage[index] = false;
    emit(state.copyWith(showThankYouMessage: newShowThankYouMessage));
    print(state.showThankYouMessage);
  }
}
