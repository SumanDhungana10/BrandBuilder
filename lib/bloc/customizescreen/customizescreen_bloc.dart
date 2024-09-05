import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/model/quick_question_model.dart';
import 'package:krofile_ai/api/customize_api.dart';

part 'customizescreen_event.dart';
part 'customizescreen_state.dart';

class CustomizeScreenBloc
    extends Bloc<CustomizepageEvent, CustomizeScreenState> {
  CustomizeScreenBloc()
      : super(CustomizeScreenState(
            typedStarterConversation: List.filled(8, ''))) {
    on<SaveStarterConversations>(_onSaveStarterConversations);
    on<FetchStarterConversations>(_onFetchStarterConversations);
    on<DeleteStarterConversation>(_onDeleteStarterConversation);
    on<UpdateStarterConversations>(_onUpdateStarterConversations);
    on<UploadGeneralFile>(_onUploadGeneralFile);
    on<ResetGeneralFileUploaded>(_onResetGeneralFileUploaded);
    on<ResetUpdateConversationStatus>(_onResetUpdateConversationStatus);
  }

  void _onSaveStarterConversations(SaveStarterConversations event,
      Emitter<CustomizeScreenState> emit) async {
    emit(state.copyWith(
      conversationUpdateStatus: ConversationUpdateStatus.updating,
    ));
    final newStarterConversation = state.typedStarterConversation;
    if (newStarterConversation.isNotEmpty) {
      for (int i = 0; i < newStarterConversation.length; i++) {
        if (newStarterConversation[i].isNotEmpty) {
          final response = await CustomizeApi()
              .saveStarterConversations(newStarterConversation[i]);
          emit(state.copyWith(
            starterConversationDeleteResponse: response,
          ));
        }
      }
    }
    newStarterConversation.clear();
    emit(state.copyWith(
        conversationUpdateStatus: ConversationUpdateStatus.updated,
        typedStarterConversation: newStarterConversation));

    add(FetchStarterConversations());
  }

  void _onResetUpdateConversationStatus(
      ResetUpdateConversationStatus event, Emitter<CustomizeScreenState> emit) {
    emit(state.copyWith(
      conversationUpdateStatus: ConversationUpdateStatus.notStarted,
    ));
  }

  void _onFetchStarterConversations(FetchStarterConversations event,
      Emitter<CustomizeScreenState> emit) async {
    try {
      final starterConversation =
          await CustomizeApi().fetchStarterConversations();
      emit(state.copyWith(starterConversation: starterConversation));
    } catch (e) {
      emit(state.copyWith(
        starterConversation: [],
      ));
    }
  }

  void _onDeleteStarterConversation(DeleteStarterConversation event,
      Emitter<CustomizeScreenState> emit) async {
    try {
      debugPrint('Deleting index: ${event.index}');
      final starterConversationDeleteResponse =
          await CustomizeApi().deleteStarterConversation(event.index);

      emit(state.copyWith(
        starterConversationDeleteResponse: starterConversationDeleteResponse,
      ));
    } catch (e) {
      emit(state.copyWith(
        starterConversationDeleteResponse: "Error during request: $e",
      ));
    }
    add(FetchStarterConversations());
  }

  // void _onUpdateStarterConversations(
  //   UpdateStarterConversations event,
  //   Emitter<CustomizeScreenState> emit,
  // ) {
  //   // if (event.index < 0 ||
  //   //     event.index >= state.typedStarterConversation.length) {
  //   //   // Index out of range, don't update
  //   //   return;
  //   // }
  //   debugPrint(
  //       'Updating index: ${event.index} with question: ${event.question}');
  //   final newStarterConversation =
  //       List<String>.from(state.typedStarterConversation);
  //   newStarterConversation[event.index] = event.question;
  //   emit(state.copyWith(typedStarterConversation: newStarterConversation));
  // }
  void _onUpdateStarterConversations(
    UpdateStarterConversations event,
    Emitter<CustomizeScreenState> emit,
  ) {
    final newStarterConversation =
        List<String>.from(state.typedStarterConversation);

    // Ensure the list has 8 elements
    while (newStarterConversation.length < 8) {
      newStarterConversation.add('');
    }

    // Calculate the correct index
    final int updatedIndex = state.starterConversation.length + event.index;

    if (updatedIndex >= 0 && updatedIndex < 8) {
      newStarterConversation[updatedIndex] = event.question;
      emit(state.copyWith(typedStarterConversation: newStarterConversation));
    } else {
      debugPrint('Invalid index: $updatedIndex');
    }
  }

  void _onUploadGeneralFile(
      UploadGeneralFile event, Emitter<CustomizeScreenState> emit) async {
    final file = event.file;
    emit(state.copyWith(
      generalFile: file,
      fileUploadStatus: CustomizeFileUploadStatus.uploading,
    ));
    try {
      final String result = await CustomizeApi().uploadGeneralFile(file);
      emit(state.copyWith(
        fileuploadedresponse: result,
        fileUploadStatus: CustomizeFileUploadStatus.uploaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        fileuploadedresponse: "Error during request: $e",
        fileUploadStatus: CustomizeFileUploadStatus.failed,
      ));
    }
  }

  void _onResetGeneralFileUploaded(
      ResetGeneralFileUploaded event, Emitter<CustomizeScreenState> emit) {
    emit(state.copyWith(
      fileUploadStatus: CustomizeFileUploadStatus.notStarted,
    ));
  }
}
