import '../core/services/notification_service.dart';
import '../env/environment.dart';
import 'notification_service_impl.dart';

class AppRepository {
  AppRepository(this.env);

  final Environment env;

  late final NotificationService notificationService;

  Future<void> init() async {
    notificationService = NotificationServiceImpl();
  }
}
