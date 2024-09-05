import 'package:dio/dio.dart';
import 'package:krofile_ai/http.dart';

class FaqApi {
  Future<String> saveQuestion(String question) async {
    try {
      Response response = await dio.post(
        '/save_content_with_type',
        data: FormData.fromMap({
          'type': 'question',
          'content': question,
          'username': username,
        }),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        String data = response.data['response'];
        return data;
      } else {
        return 'Unexpected status code: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error during request: $e';
    }
  }
  
Future<List<String>> getFAQ() async {
    try {
      Response response = await dio.post(
        '/get_fav_question',
        data: FormData.fromMap({
          'username': username,
        }),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List<String> questions = List<String>.from(data['questions']);
        return questions;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }


  Future<String> deleteFAQ(String question) async {
    try {
      Response response = await dio.post(
        '/delete_fav_entry',
        data: FormData.fromMap({
          'content': question,
          'username': username,
        }),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        String data = response.data['message'];
        return data;
      } else {
        return 'Unexpected status code: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error during request: $e';
    }
  }
}
