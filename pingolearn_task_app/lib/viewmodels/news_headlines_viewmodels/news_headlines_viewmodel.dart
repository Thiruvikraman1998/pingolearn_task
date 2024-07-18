import 'package:flutter/cupertino.dart';
import 'package:pingolearn_task_app/services/remote/news_headlines_service.dart';
import 'package:pingolearn_task_app/widgets/ui_providers/loading_widget_provider.dart';

import '../../models/news_headlines_model.dart';

class NewsHeadLineProvider extends ChangeNotifier with LoadingWidgetProvider {
  final NewsHeadlinesService _newsHeadlinesService = NewsHeadlinesService();
  List<NewsHeadlinesModel> _newsHeadLines = [];

  Future<void> getNewsHeadlines() async {
    updateLoadingState(true);
    _newsHeadLines = await _newsHeadlinesService.fetchTopNewsHeadlines();
    notifyListeners();
    updateLoadingState(false);
  }

  List<NewsHeadlinesModel> get newsHeadLines => _newsHeadLines;
}
