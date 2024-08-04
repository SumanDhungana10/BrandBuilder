import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'responsefeedback_event.dart';
part 'responsefeedback_state.dart';

class ResponsefeedbackBloc
    extends Bloc<ResponsefeedbackEvent, ResponsefeedbackState> {
  ResponsefeedbackBloc() : super(const ResponsefeedbackState()) {
    on<LikeFeedback>(_onLikeFeedback);
    on<DislikeFeedback>(_onDislikeFeedback);
    on<CloseDislikeFeedback>(_onCloseDislikeFeedback);
    on<RegenerateFeedback>(_onRegenerateFeedback);
    on<CloseRegenerateFeedback>(_onCloseRegenerateFeedback);
    on<ShowThankYouMessage>(_onShowThankYouMessage);
    on<CloseThankYouMessage>(_onCloseThankYouMessage);
  }

  void _onLikeFeedback(
      LikeFeedback event, Emitter<ResponsefeedbackState> emit) {
    final newLikedIndex = {...state.isLikedPressed};
    newLikedIndex[event.index] = true;
    emit(state.copyWith(isLikedPressed: newLikedIndex));
  }

  void _onDislikeFeedback(
      DislikeFeedback event, Emitter<ResponsefeedbackState> emit) {
    final newDisLikedIndex = {...state.disLikedIndex};
    final newIsDislikedPressed = {...state.isDislikedPressed};
    newIsDislikedPressed[event.index] = true;
    newDisLikedIndex[event.index] = true;
    emit(state.copyWith(
        disLikedIndex: newDisLikedIndex,
        isDislikedPressed: newIsDislikedPressed));
  }

  void _onCloseDislikeFeedback(
      CloseDislikeFeedback event, Emitter<ResponsefeedbackState> emit) {
    final newDisLikedIndex = {...state.disLikedIndex};
    newDisLikedIndex.remove(event.index);
    emit(state.copyWith(disLikedIndex: newDisLikedIndex));
  }

  void _onRegenerateFeedback(
      RegenerateFeedback event, Emitter<ResponsefeedbackState> emit) {
    final newRegeneratedIndex = {...state.regeneratedIndex};
    newRegeneratedIndex[event.index] = true;
    emit(state.copyWith(regeneratedIndex: newRegeneratedIndex));
  }

  void _onCloseRegenerateFeedback(
      CloseRegenerateFeedback event, Emitter<ResponsefeedbackState> emit) {
    final newRegeneratedIndex = {...state.regeneratedIndex};
    newRegeneratedIndex[event.index] = false;
    emit(state.copyWith(regeneratedIndex: newRegeneratedIndex));
  }

  void _onShowThankYouMessage(
      ShowThankYouMessage event, Emitter<ResponsefeedbackState> emit) {
    final newShowThankYouMessage = {...state.showThankYouMessage};
    newShowThankYouMessage[event.index] = true;
    emit(state.copyWith(showThankYouMessage: newShowThankYouMessage));

    Timer(const Duration(milliseconds: 2000), () {
      add(CloseThankYouMessage(event.index));
    });
  }

  void _onCloseThankYouMessage(
      CloseThankYouMessage event, Emitter<ResponsefeedbackState> emit) {
    final newShowThankYouMessage = {...state.showThankYouMessage};
    newShowThankYouMessage[event.index] = false;
    emit(state.copyWith(showThankYouMessage: newShowThankYouMessage));
  }
}
