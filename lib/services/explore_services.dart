import 'package:dio/dio.dart';
import 'package:krofile_ai/http.dart';

Future<List<String>> fetchExploreCategories() async {
  try {
    Response response = await dio.post('/get_categories');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['response'];
      List<String> categories =
          data.map((category) => category.toString()).toList();
      return categories;
    } else {
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error during request: $e');
  }
}

Future<List<String>> fetchSubCategories(String category) async {
  try {
    Response response = await dio.post(
      '/get_sub_categories',
      data: FormData.fromMap({
        'category': category,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['response'];
      List<String> subCategories =
          data.map((subCategory) => subCategory.toString()).toList();
      return subCategories;
    } else {
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error during request: $e');
  }
}

Future<List<String>> fetchQuestion(String category, String subCategory) async {
  try {
    Response response = await dio.post(
      '/get_questions_by_categories',
      data: FormData.fromMap({
        'category': category,
        'subcategory': subCategory,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['response'];
      List<String> questions =
          data.map((question) => question.toString()).toList();
      return questions;
    } else {
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error during request: $e');
  }
}
