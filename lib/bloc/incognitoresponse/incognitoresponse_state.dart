part of 'incognitoresponse_bloc.dart';

class IncognitoResponseState extends Equatable {
  final bool isQuestionType;
  final List<String> questionList;
  final List<IncognitoQuestionAnswer> questionAnswerList;
  final PlatformFile? file;
  final String? fileuploadedresponse;
  final FileUploadStatus fileUploadStatus;
   final String? fileDeleteResponse;
  final String? historyDeleteResponse;
  final Map<int, bool> regeneratingIndices;


  const IncognitoResponseState({
    this.isQuestionType = false,
    this.questionList = const [],
    this.questionAnswerList = const [],
    this.file,
    this.fileuploadedresponse,
    this.fileUploadStatus = FileUploadStatus.notStarted,
    this.fileDeleteResponse,
    this.historyDeleteResponse,
    this.regeneratingIndices = const {},
  });

  IncognitoResponseState copyWith({
    bool? isQuestionType,
    List<String>? questionList,
    List<IncognitoQuestionAnswer>? questionAnswerList,
    PlatformFile Function()? file,
    String? fileuploadedresponse,
    FileUploadStatus? fileUploadStatus,
    String? fileDeleteResponse,
    String? historyDeleteResponse,
    Map<int, bool>? regeneratingIndices,
  }) {
    return IncognitoResponseState(
      isQuestionType: isQuestionType ?? this.isQuestionType,
      questionList: questionList ?? this.questionList,
      questionAnswerList: questionAnswerList ?? this.questionAnswerList,
      file: file != null ? file() : this.file,
      fileuploadedresponse: fileuploadedresponse ?? this.fileuploadedresponse,
      fileUploadStatus: fileUploadStatus ?? this.fileUploadStatus,
      fileDeleteResponse: fileDeleteResponse ?? this.fileDeleteResponse,
      historyDeleteResponse: historyDeleteResponse ?? this.historyDeleteResponse,
      regeneratingIndices: regeneratingIndices ?? this.regeneratingIndices,

    );
  }

  @override
  List<Object?> get props => [
        isQuestionType,
        questionList,
        questionAnswerList,
        file,
        fileuploadedresponse,
        fileUploadStatus,
        fileDeleteResponse,
        historyDeleteResponse,
        regeneratingIndices,
      ];
}

class IncognitoQuestionAnswer extends Equatable {
  final String question;
  final String answer;
  final bool isLoading;
  final bool isNewResponse;
  final bool isAnimationCompleted;

  const IncognitoQuestionAnswer(
    this.question,
    this.answer,
    this.isLoading,
    this.isNewResponse,
    {
    this.isAnimationCompleted = false,
  }
  );

  @override
  List<Object> get props => [
        question,
        answer,
        isLoading,
        isNewResponse,
        isAnimationCompleted,
      ];

  IncognitoQuestionAnswer copyWith({
    String? question,
    String? answer,
    bool? isLoading,
    PlatformFile? file,
    bool? isNewResponse,
    bool? isAnimationCompleted,
  }) {
    return IncognitoQuestionAnswer(
      question ?? this.question,
      answer ?? this.answer,
      isLoading ?? this.isLoading,
      isNewResponse ?? this.isNewResponse,
      isAnimationCompleted: isAnimationCompleted ?? this.isAnimationCompleted,
    );
  }
}
