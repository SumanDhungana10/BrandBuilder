part of 'threedot_cubit.dart';

 class ThreedotState extends Equatable {
final bool isIncognitoMode;
  const ThreedotState({this.isIncognitoMode = false});

  ThreedotState copyWith({bool? isIncognitoMode}) {
    return ThreedotState(
      isIncognitoMode: isIncognitoMode ?? this.isIncognitoMode,
    );
  }

  @override
  List<Object> get props => [
    isIncognitoMode,
  ];
}

