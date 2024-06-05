part of 'explore_cubit.dart';

class ExploreState extends Equatable {
  final List<ExploreCategory> categories;
  final String? errorMessage;
  final bool isLoading;

  const ExploreState({
    this.categories = const [],
    this.errorMessage,
    this.isLoading = false,
  });

  ExploreState copyWith({
    List<ExploreCategory>? categories,
    String? errorMessage,
    bool? isLoading,
  }) {
    return ExploreState(
      categories: categories ?? this.categories,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [categories, errorMessage, isLoading];
}
