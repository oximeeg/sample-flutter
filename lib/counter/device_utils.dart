import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtils {
  DeviceUtils._();

  static Future<String> deviceName() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        return info.model;
      } else if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        return info.utsname.machine!;
      } else {
        return 'unknown';
      }
    } catch (err) {
      return 'unknown';
    }
  }
}
