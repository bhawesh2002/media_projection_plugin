import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_projection_plugin/media_projection_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMediaProjectionPlugin platform = MethodChannelMediaProjectionPlugin();
  const MethodChannel channel = MethodChannel('media_projection_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.startScreenCapture(), true);
  });
}
