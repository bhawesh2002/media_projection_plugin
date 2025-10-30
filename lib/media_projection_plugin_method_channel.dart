import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:media_projection_plugin/models/media_projection_request.dart';

import 'media_projection_plugin_platform_interface.dart';

/// An implementation of [MediaProjectionPluginPlatform] that uses method channels.
class MethodChannelMediaProjectionPlugin extends MediaProjectionPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(
    'com/media_projection_plugin/video',
  );

  @override
  Future<bool?> startProjection(
    MediaProjectionRequest? projectionRequest,
  ) async {
    projectionRequest ??= MediaProjectionRequest();
    final result = await methodChannel.invokeMethod<bool?>(
      'startProjection',
      projectionRequest.toJson(),
    );
    return result as bool;
  }
}
