
import 'media_projection_plugin_platform_interface.dart';

class MediaProjectionPlugin {
  Future<String?> getPlatformVersion() {
    return MediaProjectionPluginPlatform.instance.getPlatformVersion();
  }
}
