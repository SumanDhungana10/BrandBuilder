import 'package:dio/dio.dart';
import 'package:krofile_ai/model/response_model.dart';

class IncognitoChatServices {
  final String url =
      "https://kiwa57hisy.us-east-1.awsapprunner.com/incognitochat";
  final String email = 'passagetoindia@gmail.com';
  final Dio dio = Dio();

  Future<String> fetchIncognitoResponse(String query) async {
    try {
      Response response = await dio.post(
        url,
        data: FormData.fromMap({
          'question': query,
          'username': email,
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
