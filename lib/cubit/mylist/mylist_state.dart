part of 'mylist_cubit.dart';

class MylistState extends Equatable {
   final List<Category> categories;
  final String? errorMessage;
  final bool isLoading;

  const MylistState({
     this.categories = const [],
    this.errorMessage,
    this.isLoading = false,
  });


  MylistState copyWith({
     List<Category>? categories,
    String? errorMessage,
    bool? isLoading,
  }) {
    return MylistState(
     categories: categories ?? this.categories,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
  @override
  List<Object?> get props => [categories, errorMessage, isLoading];
}


