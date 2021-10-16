import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateProvider.autoDispose((_) => 0);

final deviceProvider =
    StateNotifierProvider.autoDispose<DeviceNameState, AsyncValue<String>>(
  (ref) => DeviceNameState(),
);

class DeviceNameState extends StateNotifier<AsyncValue<String>> {
  DeviceNameState() : super(const AsyncValue.loading()) {
    _fetchDeviceName();
  }

  Future<void> _fetchDeviceName() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      final name = await DeviceUtils.deviceName();
      state = AsyncValue.data(name);
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    } catch (error) {
      state = AsyncValue.error(error);
    }
  }
}

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

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final device = ref.watch(deviceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(device is AsyncLoading ? 'loading' : device.value),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.state}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
