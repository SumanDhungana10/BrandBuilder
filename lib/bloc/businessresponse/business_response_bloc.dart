import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/services/business_chat_services.dart';
import 'package:krofile_ai/services/faq_services.dart';
import 'package:krofile_ai/services/showhistory_services.dart';

part 'business_response_event.dart';
part 'business_response_state.dart';

class BusinessResponseBloc
    extends Bloc<BusinessResponseEvent, BusinessResponseState> {
  final List<String> answerList = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.',
  ];

  BusinessResponseBloc() : super(const BusinessResponseState()) {
    on<HandleQuestionType>(_onHandleQuestionType);
    on<HandleRegenerate>(_onHandleRegenerate);
    on<AddQuestionAnswerList>(_onAddQuestionAnswerList);
    on<GetFaq>(_onGetFAQ);
    on<ResetTextFieldController>(_onResetTextFieldController);
    on<RemoveFaq>(_onRemoveFaq);
    on<ToggleQuestionFromFAQ>(_onToggleQuestionFromFAQ);
    on<ShowHistoryData>(_onShowHistoryData);
    on<ResetQuestionAnswerList>(_onResetQuestionAnswerList);
    on<DeleteAllHistory>(_onDeleteAllHistory);
    on<FetchHistory>(_onFetchHistory);
    on<AnimationCompleted>(_onAnimationCompleted);
  }

  void _onHandleQuestionType(
      HandleQuestionType event, Emitter<BusinessResponseState> emit) {
    if (!state.isQuestionType) {
      emit(state.copyWith(isQuestionType: true));
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

    final result = await ChatService().sendQuery(event.question);

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
  }

  Future<void> _onHandleRegenerate(
      HandleRegenerate event, Emitter<BusinessResponseState> emit) async {
    // Set the regenerating state for this index
    final updatedRegeneratingIndices =
        Map<int, bool>.from(state.regeneratingIndices)..[event.index] = true;
    final updatedQuestionAnswerList =
        List<QuestionAnswer>.from(state.questionAnswerList);
    updatedQuestionAnswerList[event.index] =
        updatedQuestionAnswerList[event.index].copyWith(
      isAnimationCompleted: false,
    );
    emit(state.copyWith(
        regeneratingIndices: updatedRegeneratingIndices,
        questionAnswerList: updatedQuestionAnswerList));

    try {
      // Fetch new answer
      final question = state.questionAnswerList[event.index].question;
      final newAnswer = await ChatService().sendQuery(question);

      // Update the answer in questionAnswerList
      final updatedQuestionAnswerList =
          List<QuestionAnswer>.from(state.questionAnswerList);
      updatedQuestionAnswerList[event.index] =
          updatedQuestionAnswerList[event.index].copyWith(
        answer: newAnswer,
        isNewResponse: true,
        isAnimationCompleted: false,
      );

      // Clear the regenerating state for this index
      updatedRegeneratingIndices.remove(event.index);

      // Emit the updated state
      emit(state.copyWith(
        questionAnswerList: updatedQuestionAnswerList,
        regeneratingIndices: updatedRegeneratingIndices,
      ));
    } catch (e) {
      // Handle error if needed

      // Clear the regenerating state for this index in case of error
      updatedRegeneratingIndices.remove(event.index);
      emit(state.copyWith(regeneratingIndices: updatedRegeneratingIndices));
    }
  }

  void _onGetFAQ(GetFaq event, Emitter<BusinessResponseState> emit) async {
    final newFaq = await FAQ().getFAQ();
    emit(state.copyWith(faq: newFaq));
    debugPrint(state.faq.toString());
  }

  void _onResetTextFieldController(
      ResetTextFieldController event, Emitter<BusinessResponseState> emit) {
    emit(state.copyWith(questionFromFAQ: ""));
  }

  void _onRemoveFaq(RemoveFaq event, Emitter<BusinessResponseState> emit) {
    // final newFaq = List<String>.from(state.faq)..remove(event.question);
    // emit(state.copyWith(faq: newFaq));
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
      ));
    emit(state.copyWith(questionAnswerList: newHistoryList));
  }

  void _onResetQuestionAnswerList(
      ResetQuestionAnswerList event, Emitter<BusinessResponseState> emit) {
    emit(state.copyWith(questionAnswerList: [], isQuestionType: false));
  }

  void _onFetchHistory(
      FetchHistory event, Emitter<BusinessResponseState> emit) async {
    emit(state.copyWith(isHistoryLoading: true));
    final historyList = await showHistory();

    emit(state.copyWith(historyList: historyList, isHistoryLoading: false));
  }

  void _onDeleteAllHistory(
      DeleteAllHistory event, Emitter<BusinessResponseState> emit) async {
    await deleteAllHistory();
    final newHistoryList = await showHistory();
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
}
