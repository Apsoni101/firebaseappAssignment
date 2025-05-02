import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _fcm.requestPermission();

    String? token = await _fcm.getToken();
    print("FCM Token: $token");

    await _fcm.subscribeToTopic('new_posts');
  }

  Future<void> sendNotificationToTopic({
    required String title,
    required String body,
  }) async {
    print('Notification would be sent: $title - $body');
  }
}
