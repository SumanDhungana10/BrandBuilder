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

class CloseIncognitoRegenerateFeedback extends IncognitoResponseEvent {
  final int index;

  const CloseIncognitoRegenerateFeedback(this.index);

  @override
  List<Object> get props => [index];
}
class ShowIncognitoThankYouMessage extends IncognitoResponseEvent {
  final int index;

  const ShowIncognitoThankYouMessage(this.index);

  @override
  List<Object> get props => [index];
}

class CloseThankYouMessage extends IncognitoResponseEvent {
  final int index;

  const CloseThankYouMessage(this.index);

  @override
  List<Object> get props => [index];
}
class IncognitoDislikeFeedback extends IncognitoResponseEvent {
  final int index;

  const IncognitoDislikeFeedback(this.index);

  @override
  List<Object> get props => [index];
}
class CloseIncognitoDislikeFeedback extends IncognitoResponseEvent {
  final int index;

  const CloseIncognitoDislikeFeedback(this.index);

  @override
  List<Object> get props => [index];
}
class ClearLikeDislikeFeedback extends IncognitoResponseEvent {
}
class IncognitoLikeFeedback extends IncognitoResponseEvent {
  final int index;

  const IncognitoLikeFeedback(this.index);

  @override
  List<Object> get props => [index];
}
