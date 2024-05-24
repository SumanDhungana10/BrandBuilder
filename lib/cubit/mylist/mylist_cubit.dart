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
}
