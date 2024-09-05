import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:krofile_ai/http.dart';

class ShowHistoryApi {
  Future<List<Map<String, dynamic>>> showHistory() async {
    try {
      Response response = await dio.post(
        '/show/history/',
        data: FormData.fromMap({
          'username': username,
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['history'];
        List<Map<String, dynamic>> history = List<Map<String, dynamic>>.from(
          data.map((item) => Map<String, dynamic>.from(item)),
        );
        return history;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Error during request: $e');
    }
  }

  Future<String> deleteAllHistory() async {
    try {
      Response response = await dio.post(
        "/delete/all-history",
        data: FormData.fromMap({
          'username': username,
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data;
      } else {
        return 'Unexpected status code: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error during request: $e';
    }
  }
}
