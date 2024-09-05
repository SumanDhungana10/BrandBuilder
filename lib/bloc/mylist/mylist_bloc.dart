
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/model/mylist.dart';
import 'package:krofile_ai/api/mylist_api.dart';

part 'mylist_event.dart';
part 'mylist_state.dart';

class MylistBloc extends Bloc<MylistEvent, MylistState> {
  MylistBloc() : super(const MylistState()) {
    on<AddCategory>(_onAddCategory);
    on<InsertMylist>(_onInsertMylist);
    on<FetchMylist>(_onFetchMylist);
    on<DeleteMylistById>(_onDeleteMylistById);
    on<DeleteMylistByTitle>(_onDeleteMylistByTitle);
    on<DeleteMylistByCategory>(_onDeleteMylistByCategory);
  }
  void _onAddCategory(AddCategory event, Emitter<MylistState> emit) {
    final List<String> newCategories = List.from(state.predefinedCategories)
      ..add(event.category);
    emit(state.copyWith(predefinedCategories: newCategories));
  }

  void _onInsertMylist(InsertMylist event, Emitter<MylistState> emit) async {
    final response = await MylistApi()
        .insertMyList(event.category, event.title, event.content);
    emit(state.copyWith(insertMessage: response));
    add(FetchMylist());
  }

  void _onFetchMylist(FetchMylist event, Emitter<MylistState> emit) async {
    final response = await MylistApi().fetchMyList();
    emit(state.copyWith(mylist: response));
  }

  void _onDeleteMylistById(DeleteMylistById event, Emitter<MylistState> emit) async {
    final response = await MylistApi().deleteMyListById(event.id);
    emit(state.copyWith(deleteByIdMessage: response));
    add(FetchMylist());
  }
  void _onDeleteMylistByTitle(DeleteMylistByTitle event, Emitter<MylistState> emit) async {
    final response = await MylistApi().deleteMyListByTitle(event.title);
    emit(state.copyWith(deleteByTitleMessage: response));
    add(FetchMylist());
  }
  void _onDeleteMylistByCategory(DeleteMylistByCategory event, Emitter<MylistState> emit) async {
    final response = await MylistApi().deleteMyListByCategory(event.category);
    emit(state.copyWith(deleteByCategoryMessage: response));
    add(FetchMylist());
  }
}
