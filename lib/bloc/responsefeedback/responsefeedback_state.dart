part of 'responsefeedback_bloc.dart';

class ResponsefeedbackState extends Equatable {
  final Map<int, bool> isLikedPressed;
  final Map<int, bool> isDislikedPressed;
  final Map<int, bool> disLikedIndex;
  final Map<int, bool> showThankYouMessage;
  final Map<int, bool> regeneratedIndex;

  const ResponsefeedbackState(
      {
      this.isLikedPressed = const {},
      this.isDislikedPressed = const {},  
      this.disLikedIndex = const {},
      this.regeneratedIndex = const {},
      this.showThankYouMessage = const {}});

  ResponsefeedbackState copyWith({
    Map<int, bool>? isLikedPressed,
    Map<int, bool>? isDislikedPressed,
    Map<int, bool>? disLikedIndex,
    Map<int, bool>? regeneratedIndex,
    Map<int, bool>? showThankYouMessage,
  }) {
    return ResponsefeedbackState(
      isLikedPressed: isLikedPressed ?? this.isLikedPressed,
      isDislikedPressed: isDislikedPressed ?? this.isDislikedPressed,
      disLikedIndex: disLikedIndex ?? this.disLikedIndex,
      regeneratedIndex: regeneratedIndex ?? this.regeneratedIndex,
      showThankYouMessage: showThankYouMessage ?? this.showThankYouMessage,
    );
  }

  @override
  List<Object> get props => [
        isLikedPressed,
        isDislikedPressed,
        disLikedIndex,
        regeneratedIndex,
        showThankYouMessage,
      ];
}