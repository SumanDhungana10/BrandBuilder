import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'responsepage_state.dart';

class ResponsepageCubit extends Cubit<ResponsepageState> {
  final List<String> answerList = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.'
  ];
  ResponsepageCubit() : super(const ResponsepageState());

  void handelQuestionType() {
    if (state.isQuestionType == false) {
      emit(state.copyWith(isQuestionType: true));
    }
  }

  void addQuestionAnswerList(String question) {
    final newQuestionAnswerList = [...state.questionAnswerList];

    newQuestionAnswerList.add({
      'question': question,
      'answer': answerList[state.questionList.length % answerList.length],
    });
    // newQuestionAnswerList.insert(0, {
    //   'id': state.questionAnswerList.length + 1,
    //   'question': question,
    //   'answer': answerList[state.questionList.length % answerList.length],
    // });

    emit(state.copyWith(questionAnswerList: newQuestionAnswerList));
  }

  void regenerateAnswer(int index, String question) {
    final newQuestionAnswerList = [...state.questionAnswerList];
    if (newQuestionAnswerList[index]['question'] == question) {
      newQuestionAnswerList[index]['answer'] =
          answerList[newQuestionAnswerList.length % answerList.length + 1];
    }
    emit(state.copyWith(
        questionAnswerList: newQuestionAnswerList)); // Emit the new state
  }

  void addFaq(String question) {
    final newFaq = [...state.faq];
    newFaq.add(question);
    emit(state.copyWith(faq: newFaq));
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

  void toggleDislike(int index) {
    final newDisLikedIndex = [...state.disLikedIndex];

    newDisLikedIndex.add(index);
    emit(state.copyWith(isDisliked: true, disLikedIndex: newDisLikedIndex));
  }

  void closeFeedBack(int index) {
    final newDisLikedIndex = [...state.disLikedIndex];
    newDisLikedIndex.remove(index);
    emit(state.copyWith(isDisliked: false, disLikedIndex: newDisLikedIndex));
  }
}
