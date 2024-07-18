import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:pingolearn_task_app/services/firebase_remote_config/remote_config_keys.dart';

import '../../viewmodels/remote_config_viewmodel/remote_config_viewmode.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
  final FirebaseRemoteConfig _firebaseRemoteConfig;
  static FirebaseRemoteConfigService? _instance;

  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  ///helper functions
  String getLocationFromRemoteConfig(String key) {
    return _firebaseRemoteConfig.getString(key);
  }

  // final message = FirebaseRemoteConfigService()
  //     .getLocationFromRemoteConfig(RemoteConfigKeys.newsLocation);

  /// Set remote config settings
  Future<void> _setRemoteConfigSettings() async {
    _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 3),
        minimumFetchInterval: const Duration(seconds: 3),
      ),
    );
  }

  /// Set initial default location data
  Future<void> _setDefaultLocation() async {
    _firebaseRemoteConfig.setDefaults({RemoteConfigKeys.newsLocation: "IN"});
  }

  /// Fetch data from remote config
  Future<void> _fetchLocationFromRemoteConfig() async {
    bool locationFetched = await _firebaseRemoteConfig.fetchAndActivate();
    if (locationFetched) {}
  }

  /// Initializer for helper methods
  Future<void> initializeConfigMethods() async {
    _setRemoteConfigSettings();
    // _setDefaultLocation();
    // getLocationFromRemoteConfig(RemoteConfigKeys.newsLocation);
    _fetchLocationFromRemoteConfig();
  }
}
