part of 'threedot_cubit.dart';

 class ThreedotState extends Equatable {
final bool isHistoryOpen;
  const ThreedotState({this.isHistoryOpen = false});

  ThreedotState copyWith({bool? isHistoryOpen,}) {
    return ThreedotState(
      isHistoryOpen: isHistoryOpen ?? this.isHistoryOpen,
    );
  }

  @override
  List<Object> get props => [
    isHistoryOpen,
  ];
}

