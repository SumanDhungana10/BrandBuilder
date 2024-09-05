import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/api/business_chat_api.dart';
import 'package:krofile_ai/api/faq_api.dart';
import 'package:krofile_ai/api/feedback_api.dart';
import 'package:krofile_ai/api/showhistory_api.dart';

part 'business_response_event.dart';
part 'business_response_state.dart';

class BusinessResponseBloc
    extends Bloc<BusinessResponseEvent, BusinessResponseState> {
  BusinessResponseBloc() : super(const BusinessResponseState()) {
    on<HandleQuestionType>(_onHandleQuestionType);
    on<HandleRegenerate>(_onHandleRegenerate);
    on<AddQuestionAnswerList>(_onAddQuestionAnswerList);
    on<SaveFaqQuestion>(_onSaveFaqQuestion);
    on<GetFaq>(_onGetFAQ);
    on<RemoveFaq>(_onRemoveFaq);
    on<ResetTextFieldController>(_onResetTextFieldController);
    on<ToggleQuestionFromFAQ>(_onToggleQuestionFromFAQ);
    on<ShowHistoryData>(_onShowHistoryData);
    on<ResetQuestionAnswerList>(_onResetQuestionAnswerList);
    on<DeleteAllHistory>(_onDeleteAllHistory);
    on<FetchHistory>(_onFetchHistory);
    on<AnimationCompleted>(_onAnimationCompleted);
    on<CloseRegenerateFeedback>(_onCloseRegenerateFeedback);
    on<ResponseFeedback>(_onResponseFeedback);
    on<SaveFeedback>(_onSaveFeedback);
    on<ShowThankYouMessage>(_onShowThankYouMessage);
    on<CloseThankYouMessage>(_onCloseThankYouMessage);
    on<LikeFeedback>(_onLikeFeedback);
    on<DislikeFeedback>(_onDislikeFeedback);
    on<CloseDislikeFeedback>(_onCloseDislikeFeedback);
    on<ClearLikedDisliked>(_onClearLikedDisliked);
  }

  void _onHandleQuestionType(
      HandleQuestionType event, Emitter<BusinessResponseState> emit) {
    if (!state.isQuestionProvided) {
      emit(state.copyWith(isQuestionProvided: true));
    }
  }

  Future<void> _onAddQuestionAnswerList(
      AddQuestionAnswerList event, Emitter<BusinessResponseState> emit) async {
    final newQuestionAnswerList =
        List<QuestionAnswer>.from(state.questionAnswerList)
          ..add(QuestionAnswer(
            event.question,
            "",
            true,
            false,
          ));

    for (int i = 0; i < newQuestionAnswerList.length - 1; i++) {
      newQuestionAnswerList[i] = newQuestionAnswerList[i].copyWith(
        isLoading: false,
        isNewResponse: false,
      );
    }

    emit(state.copyWith(questionAnswerList: newQuestionAnswerList));

    final result = await BusinessChatApi().sendQuestion(event.question);

    final updatedQuestionAnswerList =
        List<QuestionAnswer>.from(newQuestionAnswerList)
          ..[newQuestionAnswerList.length - 1] = QuestionAnswer(
            event.question,
            result,
            false,
            true,
          );

    emit(state.copyWith(
      questionAnswerList: updatedQuestionAnswerList,
    ));
    add(FetchHistory());
  }

  Future<void> _onHandleRegenerate(
      HandleRegenerate event, Emitter<BusinessResponseState> emit) async {
    final updatedRegeneratingIndices =
        Map<int, bool>.from(state.regeneratingIndices)..[event.index] = true;
    final updatedQuestionAnswerList =
        List<QuestionAnswer>.from(state.questionAnswerList);
    updatedQuestionAnswerList[event.index] =
        updatedQuestionAnswerList[event.index].copyWith(
      isLoading: true,
      isAnimationCompleted: false,
    );
    emit(state.copyWith(
        regeneratingIndices: updatedRegeneratingIndices,
        questionAnswerList: updatedQuestionAnswerList));

    try {
      // Fetch new answer
      final question = state.questionAnswerList[event.index].question;
      final newAnswer = await BusinessChatApi().sendQuestion(question);

      // Update the answer in questionAnswerList
      final updatedQuestionAnswerList =
          List<QuestionAnswer>.from(state.questionAnswerList);
      updatedQuestionAnswerList[event.index] =
          updatedQuestionAnswerList[event.index].copyWith(
        answer: newAnswer,
        isLoading: false,
        isNewResponse: true,
        isAnimationCompleted: false,
      );

      emit(state.copyWith(
        questionAnswerList: updatedQuestionAnswerList,
      ));
    } catch (e) {

      updatedRegeneratingIndices.remove(event.index);
      emit(state.copyWith(regeneratingIndices: updatedRegeneratingIndices));
    }
  }

  Future<void> _onSaveFaqQuestion(
      SaveFaqQuestion event, Emitter<BusinessResponseState> emit) async {
    emit(state.copyWith(faqSavingStatus: FAQSavingStatus.inProgress));

    try {
      final response = await FaqApi().saveQuestion(event.question);

      if (response == '${event.question} saved successfully!!!') {
        final updatedFaq = List<String>.from(state.faq)..add(event.question);
        emit(state.copyWith(
            faq: updatedFaq, faqSavingStatus: FAQSavingStatus.success));
      } else {
        emit(state.copyWith(faqSavingStatus: FAQSavingStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(faqSavingStatus: FAQSavingStatus.error));
    }
  }

  void _onGetFAQ(GetFaq event, Emitter<BusinessResponseState> emit) async {
    final newFaq = await FaqApi().getFAQ();
    emit(state.copyWith(faq: newFaq));
  }

  void _onRemoveFaq(
      RemoveFaq event, Emitter<BusinessResponseState> emit) async {
    FaqApi().deleteFAQ(event.question);
    final newFaq = await FaqApi().getFAQ();
    emit(state.copyWith(faq: newFaq));
  }

  void _onResetTextFieldController(
      ResetTextFieldController event, Emitter<BusinessResponseState> emit) {
    emit(state.copyWith(questionFromFAQ: ""));
  }

  void _onToggleQuestionFromFAQ(
      ToggleQuestionFromFAQ event, Emitter<BusinessResponseState> emit) {
    emit(state.copyWith(questionFromFAQ: event.question));
  }

  void _onShowHistoryData(
      ShowHistoryData event, Emitter<BusinessResponseState> emit) {
    final newHistoryList = List<QuestionAnswer>.from(state.questionAnswerList)
      ..add(QuestionAnswer(
        event.question,
        event.answer,
        false,
        false,
        isAnimationCompleted: true,
      ));
    emit(state.copyWith(questionAnswerList: newHistoryList));
  }

  void _onResetQuestionAnswerList(
      ResetQuestionAnswerList event, Emitter<BusinessResponseState> emit) {
    emit(state.copyWith(questionAnswerList: [], isQuestionProvided: false));
  }

  void _onFetchHistory(
      FetchHistory event, Emitter<BusinessResponseState> emit) async {
    emit(state.copyWith(isHistoryLoading: true));
    final historyList = await ShowHistoryApi().showHistory();

    emit(state.copyWith(historyList: historyList, isHistoryLoading: false));
  }

  void _onDeleteAllHistory(
      DeleteAllHistory event, Emitter<BusinessResponseState> emit) async {
    await ShowHistoryApi().deleteAllHistory();
    final newHistoryList = await ShowHistoryApi().showHistory();
    emit(state.copyWith(historyList: newHistoryList));
  }

  void _onAnimationCompleted(
      AnimationCompleted event, Emitter<BusinessResponseState> emit) {
    final questionAnswerList =
        List<QuestionAnswer>.from(state.questionAnswerList);
    questionAnswerList[event.index] = questionAnswerList[event.index].copyWith(
      isAnimationCompleted: true,
    );
    emit(state.copyWith(questionAnswerList: questionAnswerList));
  }

  void _onCloseRegenerateFeedback(
      CloseRegenerateFeedback event, Emitter<BusinessResponseState> emit) {
    final updatedRegeneratingIndices =
        Map<int, bool>.from(state.regeneratingIndices)..remove(event.index);
    emit(state.copyWith(regeneratingIndices: updatedRegeneratingIndices));
  }

  void _onResponseFeedback(
      ResponseFeedback event, Emitter<BusinessResponseState> emit) async {
    try {
      final response = await FeedbackApi()
          .responseFeedbcak(event.feedback, event.content);
      emit(state.copyWith(feedbackResponse: response));
    } catch (e) {
      emit(state.copyWith(feedbackResponse: 'Error during request: $e'));
    }
  }

  void _onSaveFeedback(
      SaveFeedback event, Emitter<BusinessResponseState> emit) async {
    emit(state.copyWith(feedbackSavingStatus: FeedbackSavingStatus.saving));
    try {
      final response = await FeedbackApi().sendFeedback(event.replayRating,
          event.uxRating, event.satisfactionrating, event.addtionalFeedback);
      emit(state.copyWith(
          feedbackResponse: response,
          feedbackSavingStatus: FeedbackSavingStatus.isSaved));
    } catch (e) {
      emit(state.copyWith(
          feedbackResponse: 'Error during request: $e',
          feedbackSavingStatus: FeedbackSavingStatus.error));
    }
  }

  void _onShowThankYouMessage(
      ShowThankYouMessage event, Emitter<BusinessResponseState> emit) {
    final newShowThankYouMessage = {...state.showThankYouMessage};
    newShowThankYouMessage[event.index] = true;
    emit(state.copyWith(showThankYouMessage: newShowThankYouMessage));

    Timer(const Duration(milliseconds: 2000), () {
      add(CloseThankYouMessage(event.index));
    });
  }

  void _onCloseThankYouMessage(
      CloseThankYouMessage event, Emitter<BusinessResponseState> emit) {
    final newShowThankYouMessage = {...state.showThankYouMessage};
    newShowThankYouMessage[event.index] = false;
    emit(state.copyWith(showThankYouMessage: newShowThankYouMessage));
  }

  void _onLikeFeedback(
      LikeFeedback event, Emitter<BusinessResponseState> emit) {
    final newLikedIndex = {...state.isLikedPressed};
    newLikedIndex[event.index] = true;
    emit(state.copyWith(isLikedPressed: newLikedIndex));
  }

  void _onDislikeFeedback(
      DislikeFeedback event, Emitter<BusinessResponseState> emit) {
    final newDisLikedIndex = {...state.disLikedIndex};
    final newIsDislikedPressed = {...state.isDislikedPressed};
    newIsDislikedPressed[event.index] = true;
    newDisLikedIndex[event.index] = true;
    emit(state.copyWith(
        disLikedIndex: newDisLikedIndex,
        isDislikedPressed: newIsDislikedPressed));
  }

  void _onCloseDislikeFeedback(
      CloseDislikeFeedback event, Emitter<BusinessResponseState> emit) {
    final newDisLikedIndex = {...state.disLikedIndex};
    newDisLikedIndex.remove(event.index);
    emit(state.copyWith(disLikedIndex: newDisLikedIndex));
  }

  void _onClearLikedDisliked(
      ClearLikedDisliked event, Emitter<BusinessResponseState> emit) {
    emit(state.copyWith(
        isLikedPressed: {},
        isDislikedPressed: {},
        disLikedIndex: {},
        showThankYouMessage: {}));
  }
}
