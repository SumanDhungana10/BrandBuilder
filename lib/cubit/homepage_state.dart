part of 'homepage_cubit.dart';


 class HomepageState extends Equatable{
  final bool isSideBarOpen;
  final bool isQuestionType;
   final List<String> questionList;
  final List<Map<String, dynamic>> questionAnswerList;

  const HomepageState({ this.isSideBarOpen = true, this.isQuestionType = false,this.questionList = const [], this.questionAnswerList = const []});

  HomepageState copyWith({
    bool? isSideBarOpen,
    bool? isQuestionType,
    String? typedQuestion,
    List<String>? questionList,
    List<Map<String, dynamic>>? questionAnswerList,
  }) {
    return HomepageState(
      isSideBarOpen: isSideBarOpen ?? this.isSideBarOpen,
      isQuestionType: isQuestionType ?? this.isQuestionType,
      questionList: questionList ?? this.questionList,
      questionAnswerList: questionAnswerList ?? this.questionAnswerList,
    );
  }
  @override
  List<Object> get props => [isSideBarOpen, isQuestionType, questionList, questionAnswerList];
}


