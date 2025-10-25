
import 'media_projection_plugin_platform_interface.dart';

class MediaProjectionPlugin {
  Future<bool?> startScreenCapture() {
    return MediaProjectionPluginPlatform.instance.startScreenCapture();
  }
}
