import 'package:flutter_test/flutter_test.dart';
import 'package:media_projection_plugin/media_projection_plugin.dart';
import 'package:media_projection_plugin/media_projection_plugin_platform_interface.dart';
import 'package:media_projection_plugin/media_projection_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMediaProjectionPluginPlatform
    with MockPlatformInterfaceMixin
    implements MediaProjectionPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MediaProjectionPluginPlatform initialPlatform = MediaProjectionPluginPlatform.instance;

  test('$MethodChannelMediaProjectionPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMediaProjectionPlugin>());
  });

  test('getPlatformVersion', () async {
    MediaProjectionPlugin mediaProjectionPlugin = MediaProjectionPlugin();
    MockMediaProjectionPluginPlatform fakePlatform = MockMediaProjectionPluginPlatform();
    MediaProjectionPluginPlatform.instance = fakePlatform;

    expect(await mediaProjectionPlugin.getPlatformVersion(), '42');
  });
}
