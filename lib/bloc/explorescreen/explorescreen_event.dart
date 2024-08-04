part of 'explorescreen_bloc.dart';

abstract class ExploreScreenEvent extends Equatable {
  const ExploreScreenEvent();

  @override
  List<Object> get props => [];
}

class FetchExploreCategories extends ExploreScreenEvent {}

class SetActiveSubCategory extends ExploreScreenEvent {
  final int index;

  const SetActiveSubCategory(this.index);

  @override
  List<Object> get props => [index];
}

class ShowLeftButton extends ExploreScreenEvent {}

class HideLeftButton extends ExploreScreenEvent {}

class HandleCategoryButton extends ExploreScreenEvent {
  final int index;

  const HandleCategoryButton(this.index);

  @override
  List<Object> get props => [index];
}

class ResetCategory extends ExploreScreenEvent {}
