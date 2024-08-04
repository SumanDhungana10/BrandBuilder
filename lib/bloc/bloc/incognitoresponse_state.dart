part of 'incognitoresponse_bloc.dart';

class IncognitoResponseState extends Equatable {
  final bool isQuestionType;
  final List<String> questionList;
  final List<IncognitoQuestionAnswer> questionAnswerList;
 

  const IncognitoResponseState({
    this.isQuestionType = false,
    this.questionList = const [],
    this.questionAnswerList = const [],
  });

  IncognitoResponseState copyWith({
    bool? isQuestionType,
    List<String>? questionList,
    List<IncognitoQuestionAnswer>? questionAnswerList,
   
  }) {
    return IncognitoResponseState(
      isQuestionType: isQuestionType ?? this.isQuestionType,
      questionList: questionList ?? this.questionList,
      questionAnswerList: questionAnswerList ?? this.questionAnswerList,
     
    );
  }

  @override
  List<Object> get props => [
        isQuestionType,
        questionList,
        questionAnswerList,
  
      ];
}

class IncognitoQuestionAnswer extends Equatable {
  final String question;
  final String answer;
  final bool isLoading;
  final PlatformFile? file;

  const IncognitoQuestionAnswer(
    this.question,
    this.answer,
    this.isLoading, {
    this.file,
  });

  @override
  List<Object> get props => [question, answer, isLoading, file ?? Object()];

  IncognitoQuestionAnswer copyWith({
    String? question,
    String? answer,
    bool? isLoading,
    PlatformFile? file,
  }) {
    return IncognitoQuestionAnswer(
      question ?? this.question,
      answer ?? this.answer,
      isLoading ?? this.isLoading,
      file: file ?? this.file,
    );
  }
}
