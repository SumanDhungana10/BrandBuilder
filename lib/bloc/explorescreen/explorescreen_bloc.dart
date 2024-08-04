import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/model/explore.dart';

part 'explorescreen_event.dart';
part 'explorescreen_state.dart';

class ExploreScreenBloc extends Bloc<ExploreScreenEvent, ExploreScreenState> {
  ExploreScreenBloc() : super(const ExploreScreenState()) {
    on<FetchExploreCategories>(_onFetchCategories);
    on<SetActiveSubCategory>(_onSetActiveSubCategory);
    on<ShowLeftButton>(_onShowLeftButton);
    on<HideLeftButton>(_onHideLeftButton);
    on<HandleCategoryButton>(_onHandleCategoryButton);
    on<ResetCategory>(_onResetCategory);
  }

  Future<void> _onFetchCategories(
      FetchExploreCategories event, Emitter<ExploreScreenState> emit) async {
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

  void _onSetActiveSubCategory(
      SetActiveSubCategory event, Emitter<ExploreScreenState> emit) {
    emit(state.copyWith(activeSubCategoryIndex: event.index));
  }

  void _onShowLeftButton(ShowLeftButton event, Emitter<ExploreScreenState> emit) {
    emit(state.copyWith(showLeftButton: true));
  }

  void _onHideLeftButton(HideLeftButton event, Emitter<ExploreScreenState> emit) {
    emit(state.copyWith(showLeftButton: false));
  }

  void _onHandleCategoryButton(
      HandleCategoryButton event, Emitter<ExploreScreenState> emit) {
    emit(state.copyWith(
      actveCategoryIndex: event.index,
      showSubCategory: true,
      activeSubCategoryIndex: 0,
    ));
  }

  void _onResetCategory(ResetCategory event, Emitter<ExploreScreenState> emit) {
    emit(state.copyWith(
      actveCategoryIndex: 0,
      showSubCategory: true,
      activeSubCategoryIndex: 0,
    ));
  }
}
