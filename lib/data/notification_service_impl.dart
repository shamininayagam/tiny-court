import 'package:firebase_messaging/firebase_messaging.dart';
import '../core/services/notification_service.dart';

class _NotificationData extends NotificationData {
  _NotificationData(RemoteMessage event) {
    message = event;
  }
}

class NotificationServiceImpl implements NotificationService {
  late FirebaseMessaging _messaging;

  @override
  Future<void> dispose() async {}

  @override
  Future<String?> getToken() {
    return _messaging.getToken();
  }

  @override
  Stream<NotificationData> onMessage() {
    return FirebaseMessaging.onMessage.map<NotificationData>(
            (RemoteMessage event) => _NotificationData(event));
  }

  @override
  Stream<NotificationData> onOpen() {
    return FirebaseMessaging.onMessageOpenedApp.map<NotificationData>(
            (RemoteMessage message) => _NotificationData(message));
  }

  @override
  Future<void> init() async {
    _messaging = FirebaseMessaging.instance;
  }
}