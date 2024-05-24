part of 'homepage_cubit.dart';

class HomepageState extends Equatable {
  final bool isSideBarOpen;

  const HomepageState(
      {this.isSideBarOpen = true,});

  HomepageState copyWith({
    bool? isSideBarOpen,
    bool? isExplorePageOpen,
  }) {
    return HomepageState(
      isSideBarOpen: isSideBarOpen ?? this.isSideBarOpen,
    );
  }
  

  @override
  List<Object> get props => [isSideBarOpen, ];
}
