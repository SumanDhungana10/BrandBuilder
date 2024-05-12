import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  final List<String> answerList = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.'
  ];
  List<String> questionList = [];
  List<Map<String, String>> questionAnswerList = [];

  HomepageCubit() : super(const HomepageState());

  void toggleSideBar() {
    emit(state.copyWith(isSideBarOpen: !state.isSideBarOpen));
  }

  void handelQuestionType() {
    if (state.isQuestionType == false) {
      emit(state.copyWith(isQuestionType: true));
    }
  }

  void getQuestionList(String question) {
    final newQuestionAnswerList = [...state.questionAnswerList];

    newQuestionAnswerList.add({
      'question': question,
      'answer': answerList[questionList.length % answerList.length],
    });

    emit(state.copyWith(
        questionList: questionList, questionAnswerList: newQuestionAnswerList));
  }
}
