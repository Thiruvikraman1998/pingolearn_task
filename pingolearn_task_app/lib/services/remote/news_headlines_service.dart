import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:pingolearn_task_app/models/news_headlines_model.dart';
import 'package:pingolearn_task_app/services/firebase_remote_config/remote_config_keys.dart';
import 'package:pingolearn_task_app/services/remote/api_repository.dart';
import 'package:pingolearn_task_app/viewmodels/auth_viewmodels/auth_viewmodel.dart';

import '../firebase_remote_config/firebase_remote_config_service.dart';

class NewsHeadlinesService {
  final Dio _dio = Dio();

  Future<List<NewsHeadlinesModel>> fetchTopNewsHeadlines() async {
    final List<NewsHeadlinesModel> newsHeadlines = [];
    try {
      final Response response = await _dio.get(
        "https://newsapi.org/v2/top-headlines?apiKey=8a80a0054cf74bc4b70b28618a0994c7&country=${FirebaseRemoteConfigService().getLocationFromRemoteConfig(RemoteConfigKeys.newsLocation)}",
        //${FirebaseRemoteConfigService().getLocationFromRemoteConfig(RemoteConfigKeys.newsLocation)} //8a80a0054cf74bc4b70b28618a0994c7
        options: Options(headers: {
          // 'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }),
      );
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        List<dynamic> data = response.data['articles'];
        debugPrint("Data : $data");
        newsHeadlines
            .addAll(data.map((e) => NewsHeadlinesModel.fromJson(e)).toList());
        // debugPrint("Leng: ${newsHeadlines.length}");
      }
    } on DioException catch (e) {}
    return newsHeadlines;
  }
}
