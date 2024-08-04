import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/services/incognito_chat_services.dart';
part 'incognitoresponse_event.dart';
part 'incognitoresponse_state.dart';

class IncognitoResponseBloc
    extends Bloc<IncognitoResponseEvent, IncognitoResponseState> {

  IncognitoResponseBloc() : super(const IncognitoResponseState()) {
    on<HandleQuestionType>(_onHandleQuestionType);
    on<AddQuestionAnswerList>(_onAddQuestionAnswerList);
    on<RegenerateAnswer>(_onRegenerateAnswer);
  }

  void _onHandleQuestionType(
      HandleQuestionType event, Emitter<IncognitoResponseState> emit) {
    if (!state.isQuestionType) {
      emit(state.copyWith(isQuestionType: true));
    }
  }

  Future<void> _onAddQuestionAnswerList(
      AddQuestionAnswerList event, Emitter<IncognitoResponseState> emit) async {
    final newQuestionAnswerList =
        List<IncognitoQuestionAnswer>.from(state.questionAnswerList)
          ..add(IncognitoQuestionAnswer(
            event.question,
            "",
            true,
            file: event.files,
          ));
    emit(state.copyWith(questionAnswerList: newQuestionAnswerList));

    final result = await IncognitoChatServices().sendQuery(event.question);
    // final result = "This is a response for: ${event.question}";
    final updatedQuestionAnswerList =
        List<IncognitoQuestionAnswer>.from(state.questionAnswerList)
          ..[newQuestionAnswerList.length - 1] = IncognitoQuestionAnswer(
            event.question,
            result,
            false,
            file: event.files,
          );

    emit(state.copyWith(questionAnswerList: updatedQuestionAnswerList));
  }

  void _onRegenerateAnswer(
      RegenerateAnswer event, Emitter<IncognitoResponseState> emit) {
    final newQuestionAnswerList =
        List<IncognitoQuestionAnswer>.from(state.questionAnswerList);
    final question = state.questionAnswerList[event.index].question;
    newQuestionAnswerList[event.index] = IncognitoQuestionAnswer(
      question,
      getNewAnswer(question),
      false,
    );
    emit(state.copyWith(questionAnswerList: newQuestionAnswerList));
  }

  String getNewAnswer(String question) {
    return "This is a regenerated answer for: $question";
  }
}
