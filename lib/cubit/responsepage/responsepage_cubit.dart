import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'responsepage_state.dart';

class ResponsepageCubit extends Cubit<ResponsepageState> {
  final List<String> answerList = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.',
  ];
  ResponsepageCubit() : super(const ResponsepageState());

  void handelQuestionType() {
    if (state.isQuestionType == false) {
      emit(state.copyWith(isQuestionType: true));
    }
  }

  void addQuestionAnswerList(String question) {
    final newQuestionAnswerList = [...state.questionAnswerList];
    final newQuestionlist = [...state.questionList];
    final newHistoryList = [...state.historyList];
    newQuestionlist.add(question);
    // newQuestionAnswerList.add({
    //   'question': question,
    //   'answer': answerList[state.questionList.length % answerList.length],
    // });

    newQuestionAnswerList.add(QuestionAnswer(
      question,
      answerList[state.questionList.length % answerList.length],
    ));

    newHistoryList.add({
      'question': question,
      'answer': answerList[state.questionList.length % answerList.length],
    });

    emit(state.copyWith(
      questionList: newQuestionlist,
      questionAnswerList: newQuestionAnswerList,
      historyList: newHistoryList,
    ));
  }

  void regenerateAnswer(int index) {
    final newQuestionAnswerList = [...state.questionAnswerList];
    final question = state.questionAnswerList[index].question;
    newQuestionAnswerList[index] = QuestionAnswer(
      newQuestionAnswerList[index].question,
      getNewAnswer(question),
    );
    emit(state.copyWith(questionAnswerList: newQuestionAnswerList));
  }

  String getNewAnswer(String question) {
    return "This is a regenerated answer for: $question";
  }

  void addFaq(String question) {
    if (state.faq.contains(question)) {
      return;
    }
    if (state.faq.length < 20) {
      final newFaq = [...state.faq];
      newFaq.add(question);
      emit(state.copyWith(faq: newFaq));
    }
  }

  void resetTextFeildController() {
    emit(state.copyWith(questionFromFAQ: ""));
  }

  void removeFaq(String question) {
    final newFaq = [...state.faq];
    newFaq.remove(question);
    emit(state.copyWith(faq: newFaq));
  }

  void toggleQuestionFromFAQ(String question) {
    String newQuestion = question;

    emit(state.copyWith(questionFromFAQ: newQuestion));
  }

  void showhistoyData(String question, String answer) {
    final newHistoryList = [...state.questionAnswerList];
    newHistoryList.add(QuestionAnswer(
      question,
      answer,
    ));
    emit(state.copyWith(questionAnswerList: newHistoryList));
  }

  void resetQuestionAnswerList() {
    emit(state.copyWith(questionAnswerList: [], isQuestionType: false));
  }

  void deleteAllHistory() {
    emit(state.copyWith(historyList: []));
  }
}
