import 'package:dio/dio.dart';

abstract class ApiRepository {
  late Dio _dio;

  ApiRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/v2/top-headlines?apiKey=",
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer f9111337c4b34dc386e98c0784df5277',
          'Accept': 'application/json'
        }
      ),
    );
  }
  Dio get dio => _dio;
}
