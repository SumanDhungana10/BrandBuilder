import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/services/explore_services.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(const ExploreState()) {
    on<ExploreCategories>(_onFetchExploreCategories);
    on<HandelCategoryButton>(_onHandleCategoryButton);
    on<FetchExploreSubCategories>(_onFetchExploreSubCategories);
    on<FetchQuestions>(_onFetchQuestions);
    on<SLeftButton>(_onShowLeftButton);
    on<HLeftButton>(_onHideLeftButton);
    on<HandelSubCategoryButton>(_onHandleSubCategoryButton);
    on<ReorderCategories>(_onReorderCategories);
  }

  void _onFetchExploreCategories(
      ExploreCategories event, Emitter<ExploreState> emit) async {
    if (state.categories.isEmpty) {
      emit(state.copyWith(isCategoriesLoading: true));
    }
    final categories = await fetchExploreCategories();

    emit(state.copyWith(categories: categories, isCategoriesLoading: false));
  }

  void _onFetchExploreSubCategories(
      FetchExploreSubCategories event, Emitter<ExploreState> emit) async {
    emit(state.copyWith(isSubCategoriesLoading: true));
    final subCategories =
        await fetchSubCategories(state.categories[state.activeCategoryIndex]);

    emit(state.copyWith(
      subCategories: subCategories,
      isSubCategoriesLoading: false,
    ));

    add(FetchQuestions());
  }

  void _onFetchQuestions(
      FetchQuestions event, Emitter<ExploreState> emit) async {
    emit(state.copyWith(isQuestionsLoading: true));
    final questions = await fetchQuestion(
        state.categories[state.activeCategoryIndex],
        state.subCategories[state.activeSubCategoryIndex]);
    emit(state.copyWith(
      questions: questions,
      isQuestionsLoading: false,
    ));
  }

  void _onHandleCategoryButton(
      HandelCategoryButton event, Emitter<ExploreState> emit) {
    emit(state.copyWith(
      activeCategoryIndex: event.index,
      showSubCategory: true,
      activeSubCategoryIndex: 0,
    ));

    add(FetchExploreSubCategories(state.activeCategoryIndex));
  }

  void _onReorderCategories(
      ReorderCategories event, Emitter<ExploreState> emit) {
    final List<String> updatedCategories = List.from(state.categories);
    final selectedCategory = updatedCategories.removeAt(event.selectedIndex);
    updatedCategories.insert(0, selectedCategory);

    emit(state.copyWith(categories: updatedCategories, activeCategoryIndex: 0));
  }

  void _onHandleSubCategoryButton(
      HandelSubCategoryButton event, Emitter<ExploreState> emit) {
    emit(state.copyWith(
      activeSubCategoryIndex: event.index,
    ));
  }

  void _onShowLeftButton(SLeftButton event, Emitter<ExploreState> emit) {
    emit(state.copyWith(showLeftButton: true));
  }

  void _onHideLeftButton(HLeftButton event, Emitter<ExploreState> emit) {
    emit(state.copyWith(showLeftButton: false));
  }
}
