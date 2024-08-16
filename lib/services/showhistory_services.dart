import 'package:dio/dio.dart';
import 'package:krofile_ai/http.dart';

// const String url =
//     "https://kiwa57hisy.us-east-1.awsapprunner.com/show/history/";
// const String email = 'passagetoindia@gmail.com';

Future<List<List<dynamic>>> showHistory() async {
  try {
    Response response = await dio.post(
      '/show/history/',
      data: FormData.fromMap({
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      List<List<dynamic>> history = List<List<dynamic>>.from(
        data['history'].map(
          (item) => List<dynamic>.from(item),
        ),
      );
      return history;
    } else {
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
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
