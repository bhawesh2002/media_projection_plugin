import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'media_projection_plugin_platform_interface.dart';

/// An implementation of [MediaProjectionPluginPlatform] that uses method channels.
class MethodChannelMediaProjectionPlugin extends MediaProjectionPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('media_projection_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
