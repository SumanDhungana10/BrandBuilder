part of 'dislikefeedback_cubit.dart';

class DislikefeedbackState extends Equatable {
  final Map<int, bool> disLikedIndex;
  final Map<int,bool> showThankYouMessage;
  final Map<int, bool> regeneratedIndex;

  const DislikefeedbackState(
      {this.disLikedIndex = const {}, this.regeneratedIndex = const {}, this.showThankYouMessage = const {}});

  DislikefeedbackState copyWith({
    Map<int, bool>? disLikedIndex,
    Map<int, bool>? regeneratedIndex,
    Map<int, bool>? showThankYouMessage,}) {
    return DislikefeedbackState(
      disLikedIndex: disLikedIndex ?? this.disLikedIndex,
      regeneratedIndex: regeneratedIndex ?? this.regeneratedIndex,
      showThankYouMessage: showThankYouMessage ?? this.showThankYouMessage,
    );
  }

  @override
  List<Object> get props => [
        disLikedIndex,
        regeneratedIndex,
        showThankYouMessage,
      ];
}
