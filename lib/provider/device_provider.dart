import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deviceProvider = FutureProvider((ref) async {
  try {
    await Future.delayed(const Duration(seconds: 3));
    final deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      final info = await deviceInfo.webBrowserInfo;
      return describeEnum(info.browserName);
    } else if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return info.device;
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return info.utsname.machine;
    } else {
      return 'unknown';
    }
  } catch (err) {
    return 'unknown';
  }
});
