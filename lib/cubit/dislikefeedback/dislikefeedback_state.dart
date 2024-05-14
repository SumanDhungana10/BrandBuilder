part of 'dislikefeedback_cubit.dart';

class DislikefeedbackState extends Equatable {
  final Map<int, bool> disLikedIndex;

  const DislikefeedbackState({this.disLikedIndex = const {}});

  DislikefeedbackState copyWith({
    Map<int, bool>? disLikedIndex,
  }) {
    return DislikefeedbackState(
      disLikedIndex: disLikedIndex ?? this.disLikedIndex,
    );
  }

  @override
  List<Object> get props => [
        disLikedIndex,
      ];
}
