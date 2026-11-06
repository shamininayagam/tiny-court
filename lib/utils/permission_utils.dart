import 'dart:async';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

enum PermissionResult {
  /// The user denied access to the requested feature.
  denied,

  /// The user granted access to the requested feature.
  granted,

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  /// *Only supported on iOS.*
  restricted,

  ///User has authorized this application for limited access.
  /// *Only supported on iOS (iOS14+).*
  limited,

  /// Permission to the requested feature is permanently denied, the permission
  /// dialog will not be shown when requesting this permission. The user may
  /// still change the permission status in the settings.
  permanentlyDenied,
}

// frequently check and update this with permission library
enum AppPermission {
  calendar,
  camera,
  contacts,
  location,
  locationAlways,
  locationWhenInUse,
  mediaLibrary,
  microphone,
  phone,
  photos,
  photosAddOnly,
  reminders,
  sensors,
  sms,
  speech,
  storage,
  ignoreBatteryOptimizations,
  notification,
  accessMediaLocation,
  activityRecognition,
  unknown,
  bluetooth,
  manageExternalStorage,
  systemAlertWindow,
  requestInstallPackages,
  appTrackingTransparency,
  criticalAlerts,
  accessNotificationPolicy,
  bluetoothScan,
  bluetoothAdvertise,
  bluetoothConnect,
  nearbyWifiDevices,
  videos,
  audio,
  scheduleExactAlarm,
  sensorsAlways,
}

class PermissionsUtils {
  Completer<PermissionResult>? _cameraCompleter;

  Future<PermissionResult> _requestPermission(Permission permission) async {
    final PermissionStatus result = await permission.request();
    return PermissionResult.values[result.index];
  }

  Future<PermissionResult> requestImagesPermission() async {
    return _requestPermission(
      Platform.isIOS ? Permission.photos : Permission.storage,
    );
  }

  Future<PermissionResult> requestCameraPermission() {
    if (_cameraCompleter?.isCompleted ?? false) {
      _cameraCompleter = null;
    }
    if (_cameraCompleter == null) {
      _cameraCompleter = Completer<PermissionResult>();
      _requestPermission(
        Permission.camera,
      )
          .then(_cameraCompleter!.complete)
          .catchError(_cameraCompleter!.completeError);
    }
    return _cameraCompleter!.future;
  }

  Future<PermissionResult> requestMicroPhonePermission() async {
    return _requestPermission(Permission.microphone);
  }

  Future<PermissionResult> requestSdCardPermission() async {
    return _requestPermission(Permission.storage);
  }

  Future<bool> openSettings() => openAppSettings();

  Future<PermissionResult> requestPermissions({
    required List<AppPermission> permissions,
  }) async {
    late PermissionResult result;
    for (final Permission permission
        in permissions.map((AppPermission e) => Permission.byValue(e.index))) {
      result = await _requestPermission(permission);
      if (result != PermissionResult.granted) {
        return result;
      }
    }
    return result;
  }
}
