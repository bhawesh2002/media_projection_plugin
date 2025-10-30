import 'package:media_projection_plugin/models/media_projection_request.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'media_projection_plugin_method_channel.dart';

abstract class MediaProjectionPluginPlatform extends PlatformInterface {
  /// Constructs a MediaProjectionPluginPlatform.
  MediaProjectionPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MediaProjectionPluginPlatform _instance =
      MethodChannelMediaProjectionPlugin();

  /// The default instance of [MediaProjectionPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMediaProjectionPlugin].
  static MediaProjectionPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MediaProjectionPluginPlatform] when
  /// they register themselves.
  static set instance(MediaProjectionPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> startProjection(MediaProjectionRequest? projectionRequest) {
    throw UnimplementedError("startProjection() is not implemented");
  }
}
