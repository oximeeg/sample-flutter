import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'device_info.dart';
import 'device_utils.dart';

class DeviceNameGenerator extends StateNotifier<AsyncValue<DeviceInfo>> {
  DeviceNameGenerator() : super(const AsyncValue.loading()) {
    _fetchDeviceName();
  }

  Future<void> _fetchDeviceName() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      final name = await DeviceUtils.deviceName();
      state = AsyncValue.data(DeviceInfo(name: name));
    } on Exception catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
