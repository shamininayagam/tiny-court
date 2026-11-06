import 'package:firebase_messaging/firebase_messaging.dart';

import 'app_service.dart';

abstract class NotificationData {
  late RemoteMessage message;
}

abstract class NotificationService implements AppService {
  Future<String?> getToken();

  Stream<NotificationData> onMessage();

  Stream<NotificationData> onOpen();
}
