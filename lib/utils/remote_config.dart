import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  static late FirebaseRemoteConfig _remoteConfig;

  static Future<void> init() async {
    _remoteConfig = FirebaseRemoteConfig.instance;

    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await _remoteConfig.fetchAndActivate();
  }

  static fetchTokenApi() async {
    String tokenApi = _remoteConfig.getString('token_api');
    return tokenApi;
  }

  static FirebaseRemoteConfig get instance => _remoteConfig;
}
