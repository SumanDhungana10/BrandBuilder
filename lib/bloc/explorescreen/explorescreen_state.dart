part of 'explorescreen_bloc.dart';

class ExploreScreenState extends Equatable {
  final List<ExploreCategory> categories;
  final String? errorMessage;
  final bool isLoading;
  final int actveCategoryIndex;
  final int activeSubCategoryIndex;
  final bool showSubCategory;
  final String dropDownValue;
  final bool showLeftButton;

  const ExploreScreenState({
    this.categories = const [],
    this.errorMessage,
    this.isLoading = false,
    this.actveCategoryIndex = -0,
    this.activeSubCategoryIndex = 0,
    this.showSubCategory = false,
    this.dropDownValue = '',
    this.showLeftButton = false,
  });

  ExploreScreenState copyWith({
    List<ExploreCategory>? categories,
    String? errorMessage,
    bool? isLoading,
    int? actveCategoryIndex,
    int? activeSubCategoryIndex,
    bool? showSubCategory,
    String? dropDownValue,
    bool? showLeftButton,
  }) {
    return ExploreScreenState(
      categories: categories ?? this.categories,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
      actveCategoryIndex: actveCategoryIndex ?? this.actveCategoryIndex,
      activeSubCategoryIndex:
          activeSubCategoryIndex ?? this.activeSubCategoryIndex,
      showSubCategory: showSubCategory ?? this.showSubCategory,
      dropDownValue: dropDownValue ?? this.dropDownValue,
      showLeftButton: showLeftButton ?? this.showLeftButton,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        errorMessage,
        isLoading,
        actveCategoryIndex,
        activeSubCategoryIndex,
        showSubCategory,
        dropDownValue,
        showLeftButton
      ];
}
