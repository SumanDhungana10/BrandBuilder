import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:krofile_ai/http.dart';
import 'package:krofile_ai/model/response_model.dart';

class IncognitoChatApi {
 

  Future<String> fetchIncognitoResponse(String query) async {
    try {
      Response response = await dio.post(
        '/incognitochat',
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
  Future<String> uploadIncognitoFile(PlatformFile file) async {
    try {
      Uint8List? fileBytes = file.bytes;
      if (fileBytes == null) {
        if (file.path != null) {
          fileBytes = await File(file.path!).readAsBytes();
        } else {
          throw Exception('File bytes and path are both null');
        }
      }
      Response response = await dio.post(
        '/uploadfile-incognito',
        data: FormData.fromMap({
          'file': MultipartFile.fromBytes(fileBytes, filename: file.name),
          'username': username,
        }),
        options: Options(
          contentType: Headers.multipartFormDataContentType,
        ),
      );

      if (response.statusCode == 200) {
        String data = response.data['response'];
        return data;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }

  Future<String> deleteIncognitoFile() async {
    try {
      Response response = await dio.post(
        '/delete-file-incognito',
        data: FormData.fromMap({
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
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }

  Future<String> deleteallIncognitoHistory() async {
    try {
      Response response = await dio.post(
        '/delete/all-history-incognito',
        data: FormData.fromMap({
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
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }
}
