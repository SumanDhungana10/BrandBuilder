part of 'mylist_bloc.dart';

abstract class MylistEvent extends Equatable {
  const MylistEvent();

  @override
  List<Object> get props => [];
}


class AddCategory extends MylistEvent {
  final String category;

  const AddCategory(this.category);

  @override
  List<Object> get props => [category];
}

class InsertMylist extends MylistEvent {
  final String category;
  final String title;
  final String content;

  const InsertMylist(this.category, this.title, this.content);

  @override
  List<Object> get props => [category, title, content];
}

class FetchMylist extends MylistEvent {}

class DeleteMylistById extends MylistEvent {
  final int id;

  const DeleteMylistById(this.id);

  @override
  List<Object> get props => [id];
}
class DeleteMylistByTitle extends MylistEvent {
  final String title;

  const DeleteMylistByTitle(this.title);

  @override
  List<Object> get props => [title];
}
class DeleteMylistByCategory extends MylistEvent {
  final String category;

  const DeleteMylistByCategory(this.category);

  @override
  List<Object> get props => [category];
}