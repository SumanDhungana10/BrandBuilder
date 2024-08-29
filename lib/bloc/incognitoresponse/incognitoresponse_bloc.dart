import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/helper.dart';
import 'package:krofile_ai/services/incognito_chat_services.dart';
part 'incognitoresponse_event.dart';
part 'incognitoresponse_state.dart';

class IncognitoResponseBloc
    extends Bloc<IncognitoResponseEvent, IncognitoResponseState> {
  IncognitoResponseBloc() : super(const IncognitoResponseState()) {
    on<HandleIncognitoQuestionType>(_onHandleIncognitoQuestionType);
    on<AddIncognitoQuestionAnswerList>(_onAddIncognitoQuestionAnswerList);
    on<RegenerateIncognitoAnswer>(_onRegenerateIncognitoAnswer);
    on<UploadFile>(_onUploadFile);
    on<ResetFileUploaded>(_onResetFileUploaded);
    on<IncognitoAnimationCompleted>(_onAnimationCompleted);
    on<DeleteFile>(_onDeleteFile);
    on<DeleteHistory>(_onDeleteAllHistory);
  }

  void _onHandleIncognitoQuestionType(
      HandleIncognitoQuestionType event, Emitter<IncognitoResponseState> emit) {
    if (!state.isQuestionType) {
      emit(state.copyWith(isQuestionType: true));
    }
  }

  Future<void> _onAddIncognitoQuestionAnswerList(
      AddIncognitoQuestionAnswerList event,
      Emitter<IncognitoResponseState> emit) async {
    final newQuestionAnswerList =
        List<IncognitoQuestionAnswer>.from(state.questionAnswerList)
          ..add(IncognitoQuestionAnswer(
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

    final result =
        await IncognitoChatServices().fetchIncognitoResponse(event.question);
    // final result = "This is a response for: ${event.question}";

    final updatedQuestionAnswerList =
        List<IncognitoQuestionAnswer>.from(newQuestionAnswerList)
          ..[newQuestionAnswerList.length - 1] = IncognitoQuestionAnswer(
            event.question,
            result,
            false,
            true,
          );

    emit(state.copyWith(
      questionAnswerList: updatedQuestionAnswerList,
    ));
  }

  Future<String> getNewAnswer(String question) async {
    final result =
        await IncognitoChatServices().fetchIncognitoResponse(question);
    return result;
  }

  Future<void> _onRegenerateIncognitoAnswer(
    RegenerateIncognitoAnswer event,
    Emitter<IncognitoResponseState> emit,
  ) async {
    // Set the regenerating state for this index
    final updatedRegeneratingIndices =
        Map<int, bool>.from(state.regeneratingIndices)..[event.index] = true;

    final newQuestionAnswerList =
        List<IncognitoQuestionAnswer>.from(state.questionAnswerList);
    newQuestionAnswerList[event.index] =
        newQuestionAnswerList[event.index].copyWith(
      isAnimationCompleted: false,
      isLoading: true, // Set isLoading to true while regenerating
    );

    emit(state.copyWith(
      regeneratingIndices: updatedRegeneratingIndices,
      questionAnswerList: newQuestionAnswerList,
    ));

    final index = event.index;
    final question = state.questionAnswerList[index].question;
    final newAnswer = await getNewAnswer(question);

    final updatedQuestionAnswerList =
        List<IncognitoQuestionAnswer>.from(state.questionAnswerList);
    updatedQuestionAnswerList[index] =
        updatedQuestionAnswerList[index].copyWith(
      answer: newAnswer,
      isNewResponse: true,
      isAnimationCompleted: false,
      isLoading: false, // Set isLoading back to false
    );

    // Reset the regenerating state for this index
    updatedRegeneratingIndices.remove(event.index);

    // Emit the updated state
    emit(state.copyWith(
      questionAnswerList: updatedQuestionAnswerList,
      regeneratingIndices: updatedRegeneratingIndices,
    ));
  }

  void _onAnimationCompleted(
      IncognitoAnimationCompleted event, Emitter<IncognitoResponseState> emit) {
    final newQuestionAnswerList =
        List<IncognitoQuestionAnswer>.from(state.questionAnswerList);
    newQuestionAnswerList[event.index] =
        newQuestionAnswerList[event.index].copyWith(isAnimationCompleted: true);
    emit(state.copyWith(questionAnswerList: newQuestionAnswerList));
  }

  void _onUploadFile(
      UploadFile event, Emitter<IncognitoResponseState> emit) async {
    final file = event.file;
    emit(state.copyWith(
      file: () => file,
      fileUploadStatus: FileUploadStatus.uploading,
    ));
    try {
      final String result =
          await IncognitoChatServices().uploadIncognitoFile(file);
      emit(state.copyWith(
        fileuploadedresponse: result,
        fileUploadStatus: FileUploadStatus.uploaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        fileuploadedresponse: "Error during request: $e",
        fileUploadStatus: FileUploadStatus.failed,
      ));
    }
  }

  void _onResetFileUploaded(
      ResetFileUploaded event, Emitter<IncognitoResponseState> emit) {
    emit(state.copyWith(
      fileUploadStatus: FileUploadStatus.notStarted,
    ));
  }

  void _onDeleteFile(
      DeleteFile event, Emitter<IncognitoResponseState> emit) async {
    try {
      final String result = await IncognitoChatServices().deleteIncognitoFile();
      emit(state.copyWith(
        fileDeleteResponse: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        fileDeleteResponse: "Error during file deletion: $e",
      ));
    }
  }

  void _onDeleteAllHistory(
      DeleteHistory event, Emitter<IncognitoResponseState> emit) async {
    try {
      final String result =
          await IncognitoChatServices().deleteallIncognitoHistory();
      emit(state.copyWith(
        historyDeleteResponse: result,
        questionAnswerList: [],
        isQuestionType: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        historyDeleteResponse: "Error during history deletion: $e",
      ));
    }
  }
}
