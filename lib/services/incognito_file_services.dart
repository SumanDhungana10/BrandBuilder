import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

const String url = "https://kiwa57hisy.us-east-1.awsapprunner.com";
const String email = 'passagetoindia@gmail.com';
final Dio dio = Dio();

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
      '$url/uploadfile-incognito',
      data: FormData.fromMap({
        'file': MultipartFile.fromBytes(fileBytes, filename: file.name),
        'username': email,
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
      '$url/delete-file-incognito',
      data: FormData.fromMap({
        'username': email,
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
      '$url/delete/all-history-incognito',
      data: FormData.fromMap({
        'username': email,
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
