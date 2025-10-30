import 'package:flutter_test/flutter_test.dart';
import 'package:media_projection_plugin/media_projection_plugin.dart';
import 'package:media_projection_plugin/media_projection_plugin_platform_interface.dart';
import 'package:media_projection_plugin/media_projection_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMediaProjectionPluginPlatform
    with MockPlatformInterfaceMixin
    implements MediaProjectionPluginPlatform {
  MediaProjectionPlugin projectionPlugin = MediaProjectionPlugin();
  @override
  Future<bool?> startProjection(projectionPlugin) => Future.value(true);

  @override
  Future<bool?> stopProjection() => Future.value(true);
}

void main() {
  final MediaProjectionPluginPlatform initialPlatform =
      MediaProjectionPluginPlatform.instance;

  test('$MethodChannelMediaProjectionPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMediaProjectionPlugin>());
  });

  test('startProjection', () async {
    MediaProjectionPlugin mediaProjectionPlugin = MediaProjectionPlugin();
    MockMediaProjectionPluginPlatform fakePlatform =
        MockMediaProjectionPluginPlatform();
    MediaProjectionPluginPlatform.instance = fakePlatform;

    expect(await mediaProjectionPlugin.startProjection(), true);
  });
}
