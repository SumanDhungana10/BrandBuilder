part of 'incognitoresponse_bloc.dart';

abstract class IncognitoResponseEvent extends Equatable {
  const IncognitoResponseEvent();

  @override
  List<Object> get props => [];
}

class HandleQuestionType extends IncognitoResponseEvent {}

class AddQuestionAnswerList extends IncognitoResponseEvent {
  final String question;
  final PlatformFile? files;

  const AddQuestionAnswerList({required this.question, this.files});

  @override
  List<Object> get props => [question, files ?? []];
}


class RegenerateAnswer extends IncognitoResponseEvent {
  final int index;

  const RegenerateAnswer(this.index);

  @override
  List<Object> get props => [index];
}

class ResetTextFieldController extends IncognitoResponseEvent {}

class RemoveFaq extends IncognitoResponseEvent {
  final String question;

  const RemoveFaq(this.question);

  @override
  List<Object> get props => [question];
}
