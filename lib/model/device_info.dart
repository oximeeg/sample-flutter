import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';

@freezed
class DeviceInfo with _$DeviceInfo {
  factory DeviceInfo({
    required String appName,
    required String package,
    required String flavor,
    required String deviceName,
  }) = _DeviceInfo;

  // unused
  factory DeviceInfo.fromJson(Map<String, Object?> json) =>
      _$DeviceInfoFromJson(json);
}
