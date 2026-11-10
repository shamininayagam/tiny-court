import 'package:shared_preferences/shared_preferences.dart';

import '../core/engine/rule_based_verdict_engine.dart';
import '../core/engine/verdict_engine.dart';
import '../core/services/case_service.dart';
import '../core/services/notification_service.dart';
import '../core/services/settings_service.dart';
import '../core/services/verdict_service.dart';
import '../env/environment.dart';
import 'notification_service_impl.dart';
import 'services/case_service_impl.dart';
import 'services/settings_service_impl.dart';
import 'services/verdict_service_impl.dart';
import 'storage/app_storage.dart';

class AppRepository {
  AppRepository(this.env, {SharedPreferences? prefs, VerdictEngine? engine})
      : _injectedPrefs = prefs,
        _injectedEngine = engine;

  final Environment env;
  final SharedPreferences? _injectedPrefs;
  final VerdictEngine? _injectedEngine;

  late final AppStorage storage;
  late final NotificationService notificationService;
  late final CaseService caseService;
  late final VerdictEngine verdictEngine;
  late final VerdictService verdictService;
  late final SettingsService settingsService;

  Future<void> init() async {
    final prefs = _injectedPrefs ?? await SharedPreferences.getInstance();
    storage = AppStorage(prefs);
    notificationService = NotificationServiceImpl();

    verdictEngine = _injectedEngine ?? const RuleBasedVerdictEngine();
    caseService = CaseServiceImpl(storage);
    verdictService = VerdictServiceImpl(storage, verdictEngine, caseService);
    settingsService = SettingsServiceImpl(storage);

    await settingsService.init();
    await caseService.init();
    await verdictService.init();
  }
}
