import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:krofile_ai/http.dart';
import 'package:krofile_ai/model/quick_question_model.dart';

class CustomizeApi {
  Future<String> uploadGeneralFile(PlatformFile file) async {
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

  Future<List<QuickQuestionModel>> fetchStarterConversations() async {
    try {
      Response response = await dio.post(
        '/get/quick-questions/by-username',
        data: FormData.fromMap({
          'username': username,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => QuickQuestionModel.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }

  Future<String> saveStarterConversations(String question) async {
    try {
      Response response = await dio.post(
        '/save/quick-question',
        data: FormData.fromMap({
          'username': username,
          'question': question,
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

  Future<String> deleteStarterConversation(int id) async {
    try {
      Response response = await dio.post(
        '/delete/quick-questions/by-id',
        data: FormData.fromMap({
          'id': id,
        }),
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
}
