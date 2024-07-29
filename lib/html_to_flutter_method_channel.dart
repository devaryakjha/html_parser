import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'html_to_flutter_platform_interface.dart';

/// An implementation of [HtmlToFlutterPlatform] that uses method channels.
class MethodChannelHtmlToFlutter extends HtmlToFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('html_to_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
