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

class HandleRegenerate extends BusinessResponseEvent {
  final int index;

  const HandleRegenerate(this.index);

  @override
  List<Object> get props => [index];
}

class SaveFaqQuestion extends BusinessResponseEvent {
  final String question;

  const SaveFaqQuestion(this.question);

  @override
  List<Object> get props => [question];
}

class GetFaq extends BusinessResponseEvent {
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

class FetchHistory extends BusinessResponseEvent {}

class AnimationCompleted extends BusinessResponseEvent {
  final int index;

  const AnimationCompleted(this.index);

  @override
  List<Object> get props => [index];
}

class CloseRegenerateFeedback extends BusinessResponseEvent {
  final int index;

  const CloseRegenerateFeedback(this.index);

  @override
  List<Object> get props => [index];
}
class SaveFeedback extends BusinessResponseEvent {
  final String replayRating;
  final String uxRating;
  final String satisfactionrating;
  final String addtionalFeedback;

  const SaveFeedback(this.replayRating, this.uxRating, this.satisfactionrating,
      this.addtionalFeedback);

  @override
  List<Object> get props =>
      [replayRating, uxRating, satisfactionrating, addtionalFeedback];
} 
class ResponseFeedback extends BusinessResponseEvent {
  final String feedback;
  final String content;

  const ResponseFeedback(this.feedback, this.content);

  @override
  List<Object> get props => [feedback, content];
}
class ShowThankYouMessage extends BusinessResponseEvent {
  final int index;

  const ShowThankYouMessage(this.index);

  @override
  List<Object> get props => [index];
}

class CloseThankYouMessage extends BusinessResponseEvent {
  final int index;

  const CloseThankYouMessage(this.index);

  @override
  List<Object> get props => [index];
}
class LikeFeedback extends BusinessResponseEvent {
  final int index;

  const LikeFeedback(this.index);

  @override
  List<Object> get props => [index];
}

class DislikeFeedback extends BusinessResponseEvent {
  final int index;

  const DislikeFeedback(this.index);

  @override
  List<Object> get props => [index];
}
class CloseDislikeFeedback extends  BusinessResponseEvent {
  final int index;

  const CloseDislikeFeedback(this.index);

  @override
  List<Object> get props => [index];
}

