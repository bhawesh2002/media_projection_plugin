import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'media_projection_plugin_platform_interface.dart';

/// An implementation of [MediaProjectionPluginPlatform] that uses method channels.
class MethodChannelMediaProjectionPlugin extends MediaProjectionPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.media_projection_plugin/video');

  @override
  Future<bool?> startScreenCapture() async {
    final result = await methodChannel.invokeMethod<String>('startScreenCapture');
     return result as bool;
  }
}
