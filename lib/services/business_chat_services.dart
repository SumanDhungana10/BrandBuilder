import 'package:dio/dio.dart';
import 'package:krofile_ai/http.dart';
import 'package:krofile_ai/model/response_model.dart';

class ChatService {
  Future<String> sendQuery(String query) async {
    try {
      Response response = await dio.post(
        '/businesschat',
        data: FormData.fromMap({
          'question': query,
          'username': username,
        }),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        return ResponseModel.fromJson(data).response;
      } else {
        return 'Unexpected status code: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error during request: $e';
    }
  }
}
