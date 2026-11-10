import '../env/environment.dart';
import '../keys/app_keys.dart';
import '../shared.dart';
import '../ui/tokens/app_colors.dart';
import 'app_icons.dart';

extension Env on Object {
  Environment get env => Environment.env;
}

// ignore: avoid_classes_with_only_static_members
class _AppAssets extends AppAssets {
  static final _AppAssets instance = _AppAssets();
}

// ignore: avoid_classes_with_only_static_members
class _AppConstants extends AppConstants {
  static final _AppConstants instance = _AppConstants();
}

// ignore: avoid_classes_with_only_static_members
class _AppIcons extends AppIcons {
  static final _AppIcons instance = _AppIcons();
}

// ignore: avoid_classes_with_only_static_members
class _AppAlertUtils extends AlertUtils {
  static final _AppAlertUtils instance = _AppAlertUtils();
}

class _AppKeys extends AppKeys {
  static final AppKeys instance = _AppKeys();
}

extension ObjectUtils on Object {
  AppAssets get assets => _AppAssets.instance;

  AppConstants get constants => _AppConstants.instance;

  AppColors get colors => const AppDarkColors();

  AppIcons get icons => _AppIcons.instance;

  AlertUtils get alerts => _AppAlertUtils.instance;

  AppKeys get keys => _AppKeys.instance;
}
