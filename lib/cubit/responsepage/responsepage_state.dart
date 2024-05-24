part of 'responsepage_cubit.dart';

class ResponsepageState extends Equatable {
  final bool isQuestionType;
  final List<String> questionList;
  final List<QuestionAnswer> questionAnswerList;
  final List<Map<String, dynamic>> historyList;
  final List<String> faq;
  final String questionFromFAQ;

  const ResponsepageState({
    this.isQuestionType = false,
    this.questionList = const [],
    this.questionAnswerList = const [],
    this.historyList = const [],
    this.faq = const [],
    this.questionFromFAQ = "",
  });

  ResponsepageState copyWith(
      {bool? isQuestionType,
      String? typedQuestion,
      List<String>? questionList,
      List<QuestionAnswer>? questionAnswerList,
      List<Map<String, dynamic>>? historyList,
      List<String>? faq,
      String? questionFromFAQ,
      bool? isDisliked,
      List<int>? disLikedIndex}) {
    return ResponsepageState(
      isQuestionType: isQuestionType ?? this.isQuestionType,
      questionList: questionList ?? this.questionList,
      questionAnswerList: questionAnswerList ?? this.questionAnswerList,
      historyList: historyList ?? this.historyList,
      faq: faq ?? this.faq,
      questionFromFAQ: questionFromFAQ ?? this.questionFromFAQ,
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
      ];
}

class QuestionAnswer extends Equatable {
  final String question;
  final String answer;

  const QuestionAnswer(this.question, this.answer);

  @override
  List<Object> get props => [question, answer];

  QuestionAnswer copyWith({
    String? question,
    String? answer,
  }) {
    return QuestionAnswer(
      question ?? this.question,
      answer ?? this.answer,
    );
  }
}
