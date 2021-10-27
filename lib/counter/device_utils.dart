import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceUtils {
  DeviceUtils._();

  static Future<String> deviceName() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final info = await deviceInfoPlugin.androidInfo;
        return info.model;
      } else if (Platform.isIOS) {
        final info = await deviceInfoPlugin.iosInfo;
        return info.name;
      } else {
        return 'unknown';
      }
    } catch (err) {
      return 'unknown';
    }
  }
}
