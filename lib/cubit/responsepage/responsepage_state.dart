part of 'responsepage_cubit.dart';

class ResponsepageState extends Equatable {
  final bool isQuestionType;
  final List<String> questionList;
  final List<Map<String, dynamic>> questionAnswerList;
  final List<String> faq;
  final String questionFromFAQ;
  final bool isDisliked;
  final List<int> disLikedIndex;

  const ResponsepageState({
    this.isQuestionType = false,
    this.questionList = const [],
    this.questionAnswerList = const [],
    this.faq = const [
      "What is the purpose of the app?",
      "How do I use the app?",
      "How do I contact support?"
    ],
    this.questionFromFAQ = "",
    this.isDisliked = false,
    this.disLikedIndex = const [],
  });

  ResponsepageState copyWith(
      {bool? isQuestionType,
      String? typedQuestion,
      List<String>? questionList,
      List<Map<String, dynamic>>? questionAnswerList,
      List<String>? faq,
      String? questionFromFAQ,
      bool? isDisliked,
      List<int>? disLikedIndex}) {
    return ResponsepageState(
        isQuestionType: isQuestionType ?? this.isQuestionType,
        questionList: questionList ?? this.questionList,
        questionAnswerList: questionAnswerList ?? this.questionAnswerList,
        faq: faq ?? this.faq,
        questionFromFAQ: questionFromFAQ ?? this.questionFromFAQ,
        isDisliked: isDisliked ?? this.isDisliked,
        disLikedIndex: disLikedIndex ?? this.disLikedIndex);
  }

  @override
  List<Object> get props => [
        isQuestionType,
        questionList,
        questionAnswerList,
        faq,
        questionFromFAQ,
        isDisliked,
        disLikedIndex
      ];
}
