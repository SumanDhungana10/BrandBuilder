import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/model/mylist.dart';

part 'mylist_event.dart';
part 'mylist_state.dart';

class MylistBloc extends Bloc<MylistEvent, MylistState> {
  MylistBloc() : super(const MylistState()) {
    on<FetchCategories>(_onFetchCategories);
    on<AddCategory>(_onAddCategory);
    on<AddSubCategory>(_onAddSubCategory);
    on<ClearCategory>(_onClearCategory);
    on<DeleteSubCategory>(_onDeleteSubCategory);
    on<DeleteResponse>(_onDeleteResponse);
  }

  Future<void> _onFetchCategories(
      FetchCategories event, Emitter<MylistState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final String response =
          await rootBundle.loadString('assets/data/mylist.json');
      final data = jsonDecode(response) as Map<String, dynamic>;
      final categories = (data['category'] as List)
          .map((category) => Category.fromJson(category))
          .toList();
      emit(state.copyWith(categories: categories, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void _onAddCategory(AddCategory event, Emitter<MylistState> emit) {
    final newCategories = [...state.categories];
    newCategories.add(Category(name: event.category, subcategories: []));
    emit(state.copyWith(categories: newCategories));
  }

  void _onAddSubCategory(AddSubCategory event, Emitter<MylistState> emit) {
    final newCategories = [...state.categories];
    final category = newCategories[event.categoryIndex];
    final newSubCategories = [...category.subcategories];

    final existingSubCategoryIndex = newSubCategories
        .indexWhere((subCategory) => subCategory.name == event.subCategoryName);
    if (existingSubCategoryIndex != -1) {
      final existingSubCategory = newSubCategories[existingSubCategoryIndex];
      final newResponses = [...existingSubCategory.responses, event.response];
      newSubCategories[existingSubCategoryIndex] = SubCategory(
        name: existingSubCategory.name,
        responses: newResponses,
      );
    } else {
      final newSubCategory =
          SubCategory(name: event.subCategoryName, responses: [event.response]);
      newSubCategories.add(newSubCategory);
    }

    newCategories[event.categoryIndex] = Category(
      name: category.name,
      subcategories: newSubCategories,
    );

    emit(state.copyWith(categories: newCategories));
  }

  void _onClearCategory(ClearCategory event, Emitter<MylistState> emit) {
    final newCategories = [...state.categories];
    final newSubCategories = [
      ...newCategories[event.categoryIndex].subcategories
    ];
    newSubCategories.clear();
    newCategories[event.categoryIndex] = Category(
      name: newCategories[event.categoryIndex].name,
      subcategories: newSubCategories,
    );
    emit(state.copyWith(categories: newCategories));
  }

  void _onDeleteSubCategory(
      DeleteSubCategory event, Emitter<MylistState> emit) {
    final newCategories = [...state.categories];
    final newSubCategories = [
      ...newCategories[event.categoryIndex].subcategories
    ];
    newSubCategories.removeAt(event.subCategoryIndex);
    newCategories[event.categoryIndex] = Category(
      name: newCategories[event.categoryIndex].name,
      subcategories: newSubCategories,
    );
    emit(state.copyWith(categories: newCategories));
  }

  void _onDeleteResponse(DeleteResponse event, Emitter<MylistState> emit) {
    final newCategories = [...state.categories];
    final newSubCategories = [
      ...newCategories[event.categoryIndex].subcategories
    ];
    final newResponses = [
      ...newSubCategories[event.subCategoryIndex].responses
    ];
    newResponses.removeAt(event.responseIndex);
    newSubCategories[event.subCategoryIndex] = SubCategory(
      name: newSubCategories[event.subCategoryIndex].name,
      responses: newResponses,
    );
    newCategories[event.categoryIndex] = Category(
      name: newCategories[event.categoryIndex].name,
      subcategories: newSubCategories,
    );
    emit(state.copyWith(categories: newCategories));
  }
}
