part of 'homescreen_bloc.dart';

class HomeScreenState extends Equatable {
  final bool isSideBarOpen;
  final bool isHistoryOpen;

  const HomeScreenState({
    this.isSideBarOpen = true,
    this.isHistoryOpen = false,
  });

  HomeScreenState copyWith({
    bool? isSideBarOpen,
    bool? isHistoryOpen,
  }) {
    return HomeScreenState(
      isSideBarOpen: isSideBarOpen ?? this.isSideBarOpen,
      isHistoryOpen: isHistoryOpen ?? this.isHistoryOpen,
    );
  }

  @override
  List<Object> get props => [
        isSideBarOpen,
        isHistoryOpen,
      ];
}
