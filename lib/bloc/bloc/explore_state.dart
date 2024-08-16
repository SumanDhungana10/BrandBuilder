part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  final List<String> categories;
  final List<String> subCategories;
  final List<String> questions;
  final bool isCategoriesLoading;
  final bool isSubCategoriesLoading;
  final bool isQuestionsLoading;
  final bool showSubCategory;
  final int activeCategoryIndex;
  final int activeSubCategoryIndex;
  final bool showLeftButton;


  const ExploreState(
      {this.categories = const [],
      this.subCategories = const [],
      this.questions = const [],
      this.isCategoriesLoading = false,
      this.isSubCategoriesLoading = false,
      this.isQuestionsLoading = false,
      this.showSubCategory = false,
      this.activeCategoryIndex = 0,
      this.activeSubCategoryIndex = 0,
      this.showLeftButton = false,
      });

  ExploreState copyWith({
    List<String>? categories,
    List<String>? subCategories,
    List<String>? questions,
    bool? isCategoriesLoading,
    bool? isSubCategoriesLoading,
    bool? isQuestionsLoading,
    bool? showSubCategory,
    int? activeCategoryIndex,
    int? activeSubCategoryIndex,
    bool? showLeftButton,
  }) {
    return ExploreState(
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      questions: questions ?? this.questions,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isSubCategoriesLoading: isSubCategoriesLoading ?? this.isSubCategoriesLoading,
      isQuestionsLoading: isQuestionsLoading ?? this.isQuestionsLoading,
      showSubCategory: showSubCategory ?? this.showSubCategory,
      activeCategoryIndex: activeCategoryIndex ?? this.activeCategoryIndex,
      activeSubCategoryIndex:
          activeSubCategoryIndex ?? this.activeSubCategoryIndex,
      showLeftButton: showLeftButton ?? this.showLeftButton,
    );
  }

  @override
  List<Object> get props => [
        categories,
        subCategories,
        questions,
        isCategoriesLoading,
        isSubCategoriesLoading,
        isQuestionsLoading,
        showSubCategory,
        activeCategoryIndex,
        activeSubCategoryIndex,
        showLeftButton,
      ];
}
