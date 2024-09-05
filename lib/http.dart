import 'package:dio/dio.dart';

String baseurl = 'https://bmhpybhuih.us-east-1.awsapprunner.com';
String username = 'passagetoindia@gmail.com';

Dio dio = Dio(
  BaseOptions(
    baseUrl: baseurl,
    contentType: Headers.formUrlEncodedContentType,
  ),
);
