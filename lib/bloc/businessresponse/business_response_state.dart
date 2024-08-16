part of 'business_response_bloc.dart';

class BusinessResponseState extends Equatable {
  final bool isQuestionType;
  final List<String> questionList;
  final List<QuestionAnswer> questionAnswerList;
  final List<List<dynamic>> historyList;
  final List<String> faq;
  final String questionFromFAQ;
  final bool isHistoryLoading;
  final Map<int, bool> regeneratingIndices;

  const BusinessResponseState({
    this.isQuestionType = false,
    this.questionList = const [],
    this.questionAnswerList = const [],
    this.historyList = const [],
    this.faq = const [],
    this.questionFromFAQ = "",
    this.isHistoryLoading = false,
    this.regeneratingIndices = const {},
  });

  BusinessResponseState copyWith({
    bool? isQuestionType,
    List<String>? questionList,
    List<QuestionAnswer>? questionAnswerList,
    List<List<dynamic>>? historyList,
    List<String>? faq,
    String? questionFromFAQ,
    bool? isHistoryLoading,
    Map<int, bool>? regeneratingIndices,
  }) {
    return BusinessResponseState(
      isQuestionType: isQuestionType ?? this.isQuestionType,
      questionList: questionList ?? this.questionList,
      questionAnswerList: questionAnswerList ?? this.questionAnswerList,
      historyList: historyList ?? this.historyList,
      faq: faq ?? this.faq,
      questionFromFAQ: questionFromFAQ ?? this.questionFromFAQ,
      isHistoryLoading: isHistoryLoading ?? this.isHistoryLoading,
      regeneratingIndices: regeneratingIndices ?? this.regeneratingIndices,
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
        isHistoryLoading,
        regeneratingIndices,
      ];
}

class QuestionAnswer extends Equatable {
  final String question;
  final String answer;
  final bool isLoading;
  final bool isNewResponse;
  final bool isRegenerating;
  final bool isAnimationCompleted;

  const QuestionAnswer(
    this.question,
    this.answer,
    this.isLoading,
    this.isNewResponse, {
    this.isRegenerating = false,
    this.isAnimationCompleted = false,
  });

  QuestionAnswer copyWith({
    String? question,
    String? answer,
    bool? isLoading,
    bool? isNewResponse,
    bool? isRegenerating,
    bool? isAnimationCompleted,
  }) {
    return QuestionAnswer(
      question ?? this.question,
      answer ?? this.answer,
      isLoading ?? this.isLoading,
      isNewResponse ?? this.isNewResponse,
      isRegenerating: isRegenerating ?? this.isRegenerating,
      isAnimationCompleted: isAnimationCompleted ?? this.isAnimationCompleted,
    );
  }

  @override
  List<Object> get props => [
        question,
        answer,
        isLoading,
        isNewResponse,
        isRegenerating,
        isAnimationCompleted
      ];
}
