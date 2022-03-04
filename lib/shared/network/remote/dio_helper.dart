import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() async {
    dio =  Dio(
      BaseOptions(
          baseUrl: "https://newsapi.org/", receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {

    if (dio == null) {
      init();
      return await dio!.get(url, queryParameters: query);
    } else {
      return await dio!.get(url, queryParameters: query);
    }

  }
}
