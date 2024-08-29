part of 'business_response_bloc.dart';

class BusinessResponseState extends Equatable {
  final bool isQuestionType;
  final List<String> questionList;
  final List<QuestionAnswer> questionAnswerList;
  final List<Map<String, dynamic>> historyList;
  final List<String> faq;
  final FAQSavingStatus faqSavingStatus;
  final String questionFromFAQ;
  final bool isHistoryLoading;
  final Map<int, bool> regeneratingIndices;
  final String feedbackResponse;
  final FeedbackSavingStatus feedbackSavingStatus;
  final Map<int, bool> showThankYouMessage;
  final Map<int, bool> isLikedPressed;
  final Map<int, bool> isDislikedPressed;
  final Map<int, bool> disLikedIndex;

  const BusinessResponseState({
    this.isQuestionType = false,
    this.questionList = const [],
    this.questionAnswerList = const [],
    this.historyList = const [],
    this.faq = const [],
    this.faqSavingStatus = FAQSavingStatus.initial,
    this.questionFromFAQ = "",
    this.isHistoryLoading = false,
    this.regeneratingIndices = const {},
    this.feedbackResponse = "",
    this.feedbackSavingStatus = FeedbackSavingStatus.saving,
    this.showThankYouMessage = const {},
    this.isLikedPressed = const {},
    this.isDislikedPressed = const {},
    this.disLikedIndex = const {},
  });

  BusinessResponseState copyWith({
    bool? isQuestionType,
    List<String>? questionList,
    List<QuestionAnswer>? questionAnswerList,
    List<Map<String, dynamic>>? historyList,
    List<String>? faq,
    FAQSavingStatus? faqSavingStatus,
    String? questionFromFAQ,
    bool? isHistoryLoading,
    Map<int, bool>? regeneratingIndices,
    String? feedbackResponse,
    FeedbackSavingStatus? feedbackSavingStatus,
    Map<int, bool>? showThankYouMessage,
    Map<int, bool>? isLikedPressed,
    Map<int, bool>? isDislikedPressed,
    Map<int, bool>? disLikedIndex,
  }) {
    return BusinessResponseState(
      isQuestionType: isQuestionType ?? this.isQuestionType,
      questionList: questionList ?? this.questionList,
      questionAnswerList: questionAnswerList ?? this.questionAnswerList,
      historyList: historyList ?? this.historyList,
      faq: faq ?? this.faq,
      faqSavingStatus: faqSavingStatus ?? this.faqSavingStatus,
      questionFromFAQ: questionFromFAQ ?? this.questionFromFAQ,
      isHistoryLoading: isHistoryLoading ?? this.isHistoryLoading,
      regeneratingIndices: regeneratingIndices ?? this.regeneratingIndices,
      feedbackResponse: feedbackResponse ?? this.feedbackResponse,
      feedbackSavingStatus: feedbackSavingStatus ?? this.feedbackSavingStatus,
      showThankYouMessage: showThankYouMessage ?? this.showThankYouMessage,
      isLikedPressed: isLikedPressed ?? this.isLikedPressed,
      isDislikedPressed: isDislikedPressed ?? this.isDislikedPressed,
      disLikedIndex: disLikedIndex ?? this.disLikedIndex,
    );
  }

  @override
  List<Object> get props => [
        isQuestionType,
        questionList,
        questionAnswerList,
        historyList,
        faq,
        faqSavingStatus,
        questionFromFAQ,
        isHistoryLoading,
        regeneratingIndices,
        feedbackResponse,
        feedbackSavingStatus,
        showThankYouMessage,
        isLikedPressed,
        isDislikedPressed,
        disLikedIndex,
      ];
}

class QuestionAnswer extends Equatable {
  final String question;
  final String answer;
  final bool isLoading;
  final bool isNewResponse;
  final bool isAnimationCompleted;

  const QuestionAnswer(
    this.question,
    this.answer,
    this.isLoading,
    this.isNewResponse, {
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
      isAnimationCompleted: isAnimationCompleted ?? this.isAnimationCompleted,
    );
  }

  @override
  List<Object> get props =>
      [question, answer, isLoading, isNewResponse, isAnimationCompleted];
}
