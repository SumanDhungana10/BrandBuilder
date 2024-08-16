part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class ExploreCategories extends ExploreEvent {}

class HandelCategoryButton extends ExploreEvent {
  final int index;

  const HandelCategoryButton(this.index);

  @override
  List<Object> get props => [index];
}
class HandelSubCategoryButton extends ExploreEvent {
  final int index;

  const HandelSubCategoryButton(this.index);

  @override
  List<Object> get props => [index];
}

class FetchExploreSubCategories extends ExploreEvent {
  final int index;

  const FetchExploreSubCategories(this.index);

  @override
  List<Object> get props => [index];
}
class FetchQuestions extends ExploreEvent {
} 
class ReorderCategories extends ExploreEvent {
  final int selectedIndex;

  const ReorderCategories(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
class SLeftButton extends ExploreEvent {}

class HLeftButton extends ExploreEvent {}
