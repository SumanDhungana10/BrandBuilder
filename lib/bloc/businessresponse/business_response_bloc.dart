import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/services/business_chat_services.dart';

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
    on<AddQuestionAnswerList>(_onAddQuestionAnswerList);
    on<RegenerateAnswer>(_onRegenerateAnswer);
    on<AddFaq>(_onAddFaq);
    on<ResetTextFieldController>(_onResetTextFieldController);
    on<RemoveFaq>(_onRemoveFaq);
    on<ToggleQuestionFromFAQ>(_onToggleQuestionFromFAQ);
    on<ShowHistoryData>(_onShowHistoryData);
    on<ResetQuestionAnswerList>(_onResetQuestionAnswerList);
    on<DeleteAllHistory>(_onDeleteAllHistory);
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
          ..add(QuestionAnswer(event.question, "", true, false));

    // Set isloading and isNewResponse to false for all previous responses
    for (int i = 0; i < newQuestionAnswerList.length - 1; i++) {
      newQuestionAnswerList[i] = newQuestionAnswerList[i].copyWith(
        isloading: false,
        isNewResponse: false,
      );
    }

    emit(state.copyWith(questionAnswerList: newQuestionAnswerList));

    final result = await ChatService().sendQuery(event.question);
    // final result = "This is a response for: ${event.question}";

    final updatedQuestionAnswerList =
        List<QuestionAnswer>.from(newQuestionAnswerList)
          ..[newQuestionAnswerList.length - 1] =
              QuestionAnswer(event.question, result, false, true);

    final newHistoryList = List<Map<String, dynamic>>.from(state.historyList)
      ..add({
        'question': event.question,
        'answer': result,
      });

    emit(state.copyWith(
      questionAnswerList: updatedQuestionAnswerList,
      historyList: newHistoryList,
      isLoading: false,
    ));
  }

  void _onRegenerateAnswer(
      RegenerateAnswer event, Emitter<BusinessResponseState> emit) {
    final newQuestionAnswerList =
        List<QuestionAnswer>.from(state.questionAnswerList);
    final question = state.questionAnswerList[event.index].question;

    // Set isloading and isNewResponse to false for all previous responses
    for (int i = 0; i < newQuestionAnswerList.length; i++) {
      newQuestionAnswerList[i] = newQuestionAnswerList[i].copyWith(
        isloading: false,
        isNewResponse: false,
      );
    }

    newQuestionAnswerList[event.index] = QuestionAnswer(
      question,
      getNewAnswer(question),
      false,
      true,
    );

    emit(state.copyWith(questionAnswerList: newQuestionAnswerList));
  }

  String getNewAnswer(String question) {
    return "This is a regenerated answer for: $question";
  }

  void _onAddFaq(AddFaq event, Emitter<BusinessResponseState> emit) {
    if (!state.faq.contains(event.question) && state.faq.length < 20) {
      final newFaq = List<String>.from(state.faq)..add(event.question);
      emit(state.copyWith(faq: newFaq));
    }
  }

  void _onResetTextFieldController(
      ResetTextFieldController event, Emitter<BusinessResponseState> emit) {
    emit(state.copyWith(questionFromFAQ: ""));
  }

  void _onRemoveFaq(RemoveFaq event, Emitter<BusinessResponseState> emit) {
    final newFaq = List<String>.from(state.faq)..remove(event.question);
    emit(state.copyWith(faq: newFaq));
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

  void _onDeleteAllHistory(
      DeleteAllHistory event, Emitter<BusinessResponseState> emit) {
    emit(state.copyWith(historyList: []));
  }
}
