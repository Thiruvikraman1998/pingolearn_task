import 'package:flutter/cupertino.dart';

mixin LoadingWidgetProvider on ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void updateLoadingState(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}