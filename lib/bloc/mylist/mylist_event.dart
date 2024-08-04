part of 'mylist_bloc.dart';

abstract class MylistEvent extends Equatable {
  const MylistEvent();

  @override
  List<Object> get props => [];
}

class FetchCategories extends MylistEvent {}

class AddCategory extends MylistEvent {
  final String category;

  const AddCategory(this.category);

  @override
  List<Object> get props => [category];
}

class AddSubCategory extends MylistEvent {
  final int categoryIndex;
  final String subCategoryName;
  final String response;

  const AddSubCategory(this.categoryIndex, this.subCategoryName, this.response);

  @override
  List<Object> get props => [categoryIndex, subCategoryName, response];
}

class ClearCategory extends MylistEvent {
  final int categoryIndex;

  const ClearCategory(this.categoryIndex);

  @override
  List<Object> get props => [categoryIndex];
}

class DeleteSubCategory extends MylistEvent {
  final int categoryIndex;
  final int subCategoryIndex;

  const DeleteSubCategory(this.categoryIndex, this.subCategoryIndex);

  @override
  List<Object> get props => [categoryIndex, subCategoryIndex];
}

class DeleteResponse extends MylistEvent {
  final int categoryIndex;
  final int subCategoryIndex;
  final int responseIndex;

  const DeleteResponse(
      this.categoryIndex, this.subCategoryIndex, this.responseIndex);

  @override
  List<Object> get props => [categoryIndex, subCategoryIndex, responseIndex];
}
