import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'device_info.dart';
import 'device_utils.dart';

class DeviceNameState extends StateNotifier<AsyncValue<DeviceInfo>> {
  DeviceNameState() : super(const AsyncValue.loading()) {
    _fetchDeviceName();
  }

  Future<void> _fetchDeviceName() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      final name = await DeviceUtils.deviceName();
      state = AsyncValue.data(DeviceInfo(name: name));
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    } catch (error) {
      state = AsyncValue.error(error);
    }
  }
}
