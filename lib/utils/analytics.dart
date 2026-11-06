import 'package:firebase_analytics/firebase_analytics.dart';

class _AppAnalytics extends AppAnalytics {
  static final _AppAnalytics _instance = _AppAnalytics();
}

extension AnalyticsUtils on Object {
  AppAnalytics get analytics => _AppAnalytics._instance;
}

abstract class AppAnalytics {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final AppPages _pages = AppPages._();

  AppPages get pages => _pages;

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);
}

class AppPages {
  AppPages._();

  String get homePage => 'home_page';
}
