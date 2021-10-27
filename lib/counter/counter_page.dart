import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'device_info.dart';
import 'device_name_state.dart';

final counterProvider = StateProvider.autoDispose((_) => 0);

final deviceProvider =
    StateNotifierProvider.autoDispose<DeviceNameState, AsyncValue<DeviceInfo>>(
  (ref) => DeviceNameState(),
);

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CounterPageState();
  }
}

class _CounterPageState extends HookConsumerWidget {
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
            Text(
              device is AsyncLoading ? 'loading' : device.value.name,
            ),
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
