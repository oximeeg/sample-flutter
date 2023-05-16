import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../model/device_info.dart';

final deviceProvider = FutureProvider((ref) async {
  await Future.delayed(const Duration(seconds: 3));
  final deviceInfo = DeviceInfoPlugin();
  final deviceName;
  if (kIsWeb) {
    final info = await deviceInfo.webBrowserInfo;
    deviceName = describeEnum(info.browserName);
  } else if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    deviceName = info.device;
  } else if (Platform.isIOS) {
    final info = await deviceInfo.iosInfo;
    deviceName = info.utsname.machine;
  } else {
    deviceName = 'unknown';
  }
  final packageInfo = await PackageInfo.fromPlatform();
  final appName = packageInfo.appName;
  final packageName = packageInfo.packageName;
  const flavor = String.fromEnvironment('flavor');
  return DeviceInfo(
      appName: appName,
      package: packageName,
      flavor: flavor,
      deviceName: deviceName);
});
