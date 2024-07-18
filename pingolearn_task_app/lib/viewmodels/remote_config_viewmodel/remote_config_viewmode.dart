import 'package:flutter/cupertino.dart';

class FirebaseRemoteConfigProvider extends ChangeNotifier {
  String? _newsLocation;

  /// set news location from remote config
  void setNewsLocation(String location) {
    _newsLocation = location;
    notifyListeners();
  }

  String? get newsLocation => _newsLocation;
}
