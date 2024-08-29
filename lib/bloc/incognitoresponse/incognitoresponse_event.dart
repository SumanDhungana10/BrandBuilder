part of 'incognitoresponse_bloc.dart';

abstract class IncognitoResponseEvent extends Equatable {
  const IncognitoResponseEvent();

  @override
  List<Object> get props => [];
}

class HandleIncognitoQuestionType extends IncognitoResponseEvent {}

class AddIncognitoQuestionAnswerList extends IncognitoResponseEvent {
  final String question;
 

  const AddIncognitoQuestionAnswerList({required this.question,});

  @override
  List<Object> get props => [question,];
}


class RegenerateIncognitoAnswer extends IncognitoResponseEvent {
  final int index;

  const RegenerateIncognitoAnswer(this.index);

  @override
  List<Object> get props => [index];
}

class ResetIncognitoTextFieldController extends IncognitoResponseEvent {}

class RemoveFaq extends IncognitoResponseEvent {
  final String question;

  const RemoveFaq(this.question);

  @override
  List<Object> get props => [question];
}
class IncognitoAnimationCompleted extends IncognitoResponseEvent {
  final int index;

  const IncognitoAnimationCompleted(this.index);

  @override
  List<Object> get props => [index];
}

class UploadFile extends IncognitoResponseEvent {
  final PlatformFile file;

  const UploadFile(this.file);

  @override
  List<Object> get props => [file];
}

class ResetFileUploaded extends IncognitoResponseEvent {}
class DeleteFile extends IncognitoResponseEvent {}
class DeleteHistory extends IncognitoResponseEvent {}

