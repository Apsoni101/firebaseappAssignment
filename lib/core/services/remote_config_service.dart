import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  // Default values
  static const Map<String, dynamic> _defaults = {
    'isPostingEnabled': true,
  };

  static const String keyIsPostingEnabled = 'isPostingEnabled';

  RemoteConfigService({required FirebaseRemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  Future<void> initialize() async {
    try {
      await _remoteConfig.setDefaults(_defaults);

      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));

      await _remoteConfig.fetchAndActivate();
    } catch (e) {
//      print('Error initializing Remote Config: $e');
    }
  }

  bool get isPostingEnabled => _remoteConfig.getBool(keyIsPostingEnabled);

}
