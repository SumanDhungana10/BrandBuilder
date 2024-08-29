part of 'mylist_bloc.dart';

class MylistState extends Equatable {
  final String? insertMessage;
  final List<MyListItem> mylist;
  final List<String> predefinedCategories;
  final String? deleteByIdMessage;
  final String? deleteByTitleMessage;
  final String? deleteByCategoryMessage;
  final String? errorMessage;
  final bool isLoading;

  const MylistState({
    this.insertMessage,
    this.mylist = const [],
    this.predefinedCategories =const ['Education','For Later'],
    this.deleteByIdMessage,
    this.deleteByTitleMessage,
    this.deleteByCategoryMessage,
    this.errorMessage,
    this.isLoading = false,
  });

  MylistState copyWith({
    String? insertMessage,
    List<MyListItem>? mylist,
    List<String>? predefinedCategories,
    String? deleteByIdMessage,
    String? deleteByTitleMessage,
    String? deleteByCategoryMessage,
    String? errorMessage,
    bool? isLoading,
  }) {
    return MylistState(
      insertMessage: insertMessage ?? this.insertMessage,
      mylist: mylist ?? this.mylist,
      predefinedCategories: predefinedCategories ?? this.predefinedCategories,
      deleteByIdMessage: deleteByIdMessage ?? this.deleteByIdMessage,
      deleteByTitleMessage: deleteByTitleMessage ?? this.deleteByTitleMessage,
      deleteByCategoryMessage:
          deleteByCategoryMessage ?? this.deleteByCategoryMessage,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        insertMessage,
        mylist,
        predefinedCategories,
        deleteByIdMessage,
        deleteByTitleMessage,
        deleteByCategoryMessage,
        errorMessage,
        isLoading
      ];
}
