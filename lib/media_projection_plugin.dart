import 'package:media_projection_plugin/models/media_projection_request.dart';

import 'media_projection_plugin_platform_interface.dart';

class MediaProjectionPlugin {
  Future<bool?> startProjection({MediaProjectionRequest? projectionRequest}) {
    return MediaProjectionPluginPlatform.instance.startProjection(
      projectionRequest,
    );
  }

  Future<bool?> stopProjection({MediaProjectionRequest? projectionRequest}) {
    return MediaProjectionPluginPlatform.instance.stopProjection();
  }
}
