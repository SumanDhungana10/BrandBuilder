part of 'business_response_bloc.dart';

class BusinessResponseState extends Equatable {
  final bool isQuestionType;
  final List<String> questionList;
  final List<QuestionAnswer> questionAnswerList;
  final List<Map<String, dynamic>> historyList;
  final List<String> faq;
  final String questionFromFAQ;
  final bool isLoading;
  

  const BusinessResponseState({
    this.isQuestionType = false,
    this.questionList = const [],
    this.questionAnswerList = const [],
    this.historyList = const [],
    this.faq = const [],
    this.questionFromFAQ = "",
    this.isLoading = false,
  });

  BusinessResponseState copyWith({
    bool? isQuestionType,
    List<String>? questionList,
    List<QuestionAnswer>? questionAnswerList,
    List<Map<String, dynamic>>? historyList,
    List<String>? faq,
    String? questionFromFAQ,
    bool? isLoading,
    bool? isNewResponse,
  }) {
    return BusinessResponseState(
      isQuestionType: isQuestionType ?? this.isQuestionType,
      questionList: questionList ?? this.questionList,
      questionAnswerList: questionAnswerList ?? this.questionAnswerList,
      historyList: historyList ?? this.historyList,
      faq: faq ?? this.faq,
      questionFromFAQ: questionFromFAQ ?? this.questionFromFAQ,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        isQuestionType,
        questionList,
        questionAnswerList,
        historyList,
        faq,
        questionFromFAQ,
        isLoading,
      ];
}

class QuestionAnswer extends Equatable {
  final String question;
  final String answer;
  final bool isloading;
  final bool isNewResponse;

  const QuestionAnswer(
      this.question, this.answer, this.isloading, this.isNewResponse);

  @override
  List<Object> get props => [question, answer, isloading, isNewResponse];

  QuestionAnswer copyWith({
    String? question,
    String? answer,
    bool? isloading,
    bool? isNewResponse,
  }) {
    return QuestionAnswer(
      question ?? this.question,
      answer ?? this.answer,
      isloading ?? this.isloading,
      isNewResponse ?? this.isNewResponse,
    );
  }
}
