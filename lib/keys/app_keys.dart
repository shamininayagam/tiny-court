import '../ui.dart';

class HomePageKeys {
  ValueKey<String> get increment => const ValueKey<String>('increment');
}

abstract class AppKeys {
  final HomePageKeys homePageKeys = HomePageKeys();
}
