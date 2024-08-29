import 'package:dio/dio.dart';
import 'package:krofile_ai/http.dart';
import 'package:krofile_ai/model/mylist_model.dart';

class MylistServices {
  Future<String> insertMyList(
      String category, String title, String content) async {
    try {
      Response response = await dio.post(
        '/insert/user/mylist',
        data: FormData.fromMap({
          'category': category,
          'title': title,
          'content': content,
          'username': username,
        }),
      );

      if (response.statusCode == 200) {
        String data = response.data['message'];

        return data;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }

  Future<List<MyListItem>> fetchMyList() async {
    try {
      Response response = await dio.post(
        '/show/user/mylist',
        data: FormData.fromMap({
          'username': username,
        }),
      );

      if (response.statusCode == 200) {
        MyListResponse myListResponse = MyListResponse.fromJson(response.data);
        return myListResponse.data;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }

  Future<String> deleteMyListById(int id) async {
    try {
      Response response = await dio.post(
        '/delete/user/mylist?id=$id',
        data: FormData.fromMap({
          'id': id,
          'username': username,
        }),
      );

      if (response.statusCode == 200) {
        String data = response.data['message'];
        return data;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }

  Future<String> deleteMyListByCategory(String category) async {
    try {
      Response response = await dio.post(
        '/delete/user/mylist/by-category',
        data: FormData.fromMap({
          'username': username,
          'category': category,
        }),
      );

      if (response.statusCode == 200) {
        String data = response.data['message'];
        return data;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }

  Future<String> deleteMyListByTitle(String title) async {
    try {
      Response response = await dio.post(
        '/delete/user/mylist/by-title',
        data: FormData.fromMap({'username': username, 'title': title}),
      );

      if (response.statusCode == 200) {
        String data = response.data['message'];
        return data;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }
}
