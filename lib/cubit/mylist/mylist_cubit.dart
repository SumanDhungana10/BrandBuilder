import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/model/mylist.dart';

part 'mylist_state.dart';

class MylistCubit extends Cubit<MylistState> {
  MylistCubit() : super(const MylistState());

  Future<void> fetchCategories() async {
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

  void addCategory(String category) {
    final newCategories = [...state.categories];
    newCategories.add(Category(name: category, subcategories: []));
    emit(state.copyWith(categories: newCategories));
  }

  void addSubCategory(
      int categoryIndex, String subCategoryName, String response) {
    final newCategories = [...state.categories];

    // Find the category and subcategories list
    final category = newCategories[categoryIndex];
    final newSubCategories = [...category.subcategories];

    // Check if the subcategory already exists
    final existingSubCategoryIndex = newSubCategories
        .indexWhere((subCategory) => subCategory.name == subCategoryName);
    if (existingSubCategoryIndex != -1) {
      // Subcategory exists, add the response to the existing subcategory
      final existingSubCategory = newSubCategories[existingSubCategoryIndex];
      final newResponses = [...existingSubCategory.responses, response];
      newSubCategories[existingSubCategoryIndex] = SubCategory(
        name: existingSubCategory.name,
        responses: newResponses,
      );
    } else {
      // Subcategory does not exist, create a new one with the response
      final newSubCategory =
          SubCategory(name: subCategoryName, responses: [response]);
      newSubCategories.add(newSubCategory);
    }

    // Update the category with the new subcategories
    newCategories[categoryIndex] = Category(
      name: category.name,
      subcategories: newSubCategories,
    );

    // Emit the new state
    emit(state.copyWith(categories: newCategories));
  }

  void clearCategory(int categoryIndex) {
    final newCategories = [...state.categories];
    final newSubCategories = [...newCategories[categoryIndex].subcategories];
    newSubCategories.clear();
    newCategories[categoryIndex] = Category(
      name: newCategories[categoryIndex].name,
      subcategories: newSubCategories,
    );
    emit(state.copyWith(categories: newCategories));
  }

  void deleteSubCategory(int categoryIndex, int subCategoryIndex) {
    final newCategories = [...state.categories];
    final newSubCategories = [...newCategories[categoryIndex].subcategories];
    newSubCategories.removeAt(subCategoryIndex);
    newCategories[categoryIndex] = Category(
      name: newCategories[categoryIndex].name,
      subcategories: newSubCategories,
    );
    emit(state.copyWith(categories: newCategories));
  }

  void deleteResponse(
      int categoryIndex, int subCategoryIndex, int responseIndex) {
    {
      final newCategories = [...state.categories];
      final newSubCategories = [...newCategories[categoryIndex].subcategories];
      final newResonse = [...newSubCategories[subCategoryIndex].responses];
      newResonse.removeAt(responseIndex);
      print(newResonse);
      newSubCategories[subCategoryIndex] = SubCategory(
        name: newSubCategories[subCategoryIndex].name,
        responses: newResonse,
      );
      newCategories[categoryIndex] = Category(
        name: newCategories[categoryIndex].name,
        subcategories: newSubCategories,
      );
      emit(state.copyWith(categories: newCategories));
    }
  }
}
