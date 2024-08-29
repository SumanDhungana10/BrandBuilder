part of 'customizescreen_bloc.dart';

enum ConversationDeleteStatus { notStarted, deleting, deleted, error }
enum ConversationUpdateStatus { notStarted, updating, updated, error }

class CustomizeScreenState extends Equatable {
  final List<QuickQuestionModel> starterConversation;
  final List<String> typedStarterConversation;
  final ConversationUpdateStatus conversationUpdateStatus;
  final String starterConversationDeleteResponse;
  final ConversationDeleteStatus conversationDeleteStatus;
  final PlatformFile? generalFile;
  final String? fileuploadedresponse;
  final CustomizeFileUploadStatus fileUploadStatus;
  const CustomizeScreenState(
      {this.starterConversation = const [],
      this.typedStarterConversation = const [],
      this.conversationUpdateStatus = ConversationUpdateStatus.notStarted,
      this.starterConversationDeleteResponse = '',
      this.conversationDeleteStatus = ConversationDeleteStatus.notStarted,
      this.generalFile,
      this.fileuploadedresponse = '',
      this.fileUploadStatus = CustomizeFileUploadStatus.notStarted});

  CustomizeScreenState copyWith({
    List<QuickQuestionModel>? starterConversation,
    List<String>? typedStarterConversation,
    ConversationUpdateStatus? conversationUpdateStatus,
    String? starterConversationDeleteResponse,
    ConversationDeleteStatus? conversationDeleteStatus,
    PlatformFile? generalFile,
    String? fileuploadedresponse,
    CustomizeFileUploadStatus? fileUploadStatus,
  }) {
    return CustomizeScreenState(
      starterConversation: starterConversation ?? this.starterConversation,
      conversationUpdateStatus: conversationUpdateStatus ?? this.conversationUpdateStatus,

      typedStarterConversation: typedStarterConversation ?? this.typedStarterConversation,
      starterConversationDeleteResponse:
          starterConversationDeleteResponse ?? this.starterConversationDeleteResponse,
      conversationDeleteStatus: conversationDeleteStatus ?? this.conversationDeleteStatus,
      generalFile: generalFile ?? this.generalFile,
      fileuploadedresponse: fileuploadedresponse ?? this.fileuploadedresponse,
      fileUploadStatus: fileUploadStatus ?? this.fileUploadStatus,
    );
  }

  @override
  List<Object?> get props => [
        starterConversation,
        conversationUpdateStatus,
        typedStarterConversation,
        starterConversationDeleteResponse,
        conversationDeleteStatus,
        generalFile,
        fileuploadedresponse,
        fileUploadStatus
      ];
}
