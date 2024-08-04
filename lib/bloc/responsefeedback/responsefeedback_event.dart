part of 'responsefeedback_bloc.dart';

abstract class ResponsefeedbackEvent extends Equatable {
  const ResponsefeedbackEvent();

  @override
  List<Object> get props => [];
}

class LikeFeedback extends ResponsefeedbackEvent {
  final int index;

  const LikeFeedback(this.index);

  @override
  List<Object> get props => [index];
}

class DislikeFeedback extends ResponsefeedbackEvent {
  final int index;

  const DislikeFeedback(this.index);

  @override
  List<Object> get props => [index];
}

class CloseDislikeFeedback extends ResponsefeedbackEvent {
  final int index;

  const CloseDislikeFeedback(this.index);

  @override
  List<Object> get props => [index];
}

class RegenerateFeedback extends ResponsefeedbackEvent {
  final int index;

  const RegenerateFeedback(this.index);

  @override
  List<Object> get props => [index];
}

class CloseRegenerateFeedback extends ResponsefeedbackEvent {
  final int index;

  const CloseRegenerateFeedback(this.index);

  @override
  List<Object> get props => [index];
}

class ShowThankYouMessage extends ResponsefeedbackEvent {
  final int index;

  const ShowThankYouMessage(this.index);

  @override
  List<Object> get props => [index];
}

class CloseThankYouMessage extends ResponsefeedbackEvent {
  final int index;

  const CloseThankYouMessage(this.index);

  @override
  List<Object> get props => [index];
}
