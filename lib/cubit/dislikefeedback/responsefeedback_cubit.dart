import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'responsefeedback_state.dart';

class ResponsefeedbackCubit extends Cubit<ResponsefeedbackState> {
  ResponsefeedbackCubit() : super(const ResponsefeedbackState());

  void likeFeedback(int index) {
    final newLikedIndex = {...state.isLikedPressed};
    newLikedIndex[index] = true;
    emit(state.copyWith(isLikedPressed: newLikedIndex));
  }

  void disLikeFeedback(int index) {
    final newDisLikedIndex = {...state.disLikedIndex};
    final newIsDislikedPressed = {...state.isDislikedPressed};
    newIsDislikedPressed[index] = true;
    newDisLikedIndex[index] = true;
    emit(state.copyWith(
        disLikedIndex: newDisLikedIndex,
        isDislikedPressed: newIsDislikedPressed));
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

    Timer(const Duration(milliseconds: 2000), () {
      closeThankYouMessage(index);
    });
  }

  void closeThankYouMessage(int index) {
    final newShowThankYouMessage = {...state.showThankYouMessage};
    newShowThankYouMessage[index] = false;
    emit(state.copyWith(showThankYouMessage: newShowThankYouMessage));
  }
}
