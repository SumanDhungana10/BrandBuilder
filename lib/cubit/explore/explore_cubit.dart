import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/model/explore.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(const ExploreState());

  Future<void> fetchCategories() async {
    emit(state.copyWith(isLoading: true));
    try {
      final String response =
          await rootBundle.loadString('assets/data/explore.json');
      final data = jsonDecode(response) as Map<String, dynamic>;
      final categories = (data['categories'] as List)
          .map((category) => ExploreCategory.fromJson(category))
          .toList();
      emit(state.copyWith(categories: categories, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void setActiveSubCategory(int index) {
    emit(state.copyWith(activeSubCategoryIndex: index));
  }

  void showLeftButton() {
    emit(state.copyWith(showLeftButton: true));
  }

  void hideLeftButton() {
    emit(state.copyWith(showLeftButton: false));
  }

  void handelCategoryButton(int index) {
    emit(state.copyWith(
        actveCategoryIndex: index,
        showSubCategory: true,
        activeSubCategoryIndex: 0));
  }

  void resetCategory() {
    emit(state.copyWith(
        actveCategoryIndex: 0,
        showSubCategory: true,
        activeSubCategoryIndex: 0));
  }
}
