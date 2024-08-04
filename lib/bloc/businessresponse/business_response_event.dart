part of 'business_response_bloc.dart';

abstract class BusinessResponseEvent extends Equatable {
  const BusinessResponseEvent();

  @override
  List<Object> get props => [];
}

class HandleQuestionType extends BusinessResponseEvent {}

class AddQuestionAnswerList extends BusinessResponseEvent {
  final String question;

  const AddQuestionAnswerList(this.question);

  @override
  List<Object> get props => [question];
}

class RegenerateAnswer extends BusinessResponseEvent {
  final int index;

  const RegenerateAnswer(this.index);

  @override
  List<Object> get props => [index];
}

class AddFaq extends BusinessResponseEvent {
  final String question;

  const AddFaq(this.question);

  @override
  List<Object> get props => [question];
}

class ResetTextFieldController extends BusinessResponseEvent {}

class RemoveFaq extends BusinessResponseEvent {
  final String question;

  const RemoveFaq(this.question);

  @override
  List<Object> get props => [question];
}

class ToggleQuestionFromFAQ extends BusinessResponseEvent {
  final String question;

  const ToggleQuestionFromFAQ(this.question);

  @override
  List<Object> get props => [question];
}

class ShowHistoryData extends BusinessResponseEvent {
  final String question;
  final String answer;

  const ShowHistoryData(this.question, this.answer);

  @override
  List<Object> get props => [question, answer];
}

class ResetQuestionAnswerList extends BusinessResponseEvent {}

class DeleteAllHistory extends BusinessResponseEvent {}
