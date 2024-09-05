
import 'package:dio/dio.dart';
import 'package:krofile_ai/http.dart';

class FeedbackApi {

  Future<String> sendFeedback(String replayRating, String uxRating, String satisfactionrating,String addtionalFeedback) async {
    try {
      final response = await dio.post(
        '/save/chatbot-feedback',
        data: FormData.fromMap({
         'username': username,
          'reply_rating':replayRating,
          'ux_rating':uxRating,
          'satisfaction_rating':satisfactionrating,
          'feedback':addtionalFeedback
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
  Future<String> responseFeedbcak(String feedback,String content) async {
    try {
      final response = await dio.post(
        '/save/response-feedback',
        data: FormData.fromMap({
          'username': username,
          'feedback': feedback,
          'content': content
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