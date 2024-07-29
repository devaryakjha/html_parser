import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'html_to_flutter_method_channel.dart';

abstract class HtmlToFlutterPlatform extends PlatformInterface {
  /// Constructs a HtmlToFlutterPlatform.
  HtmlToFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static HtmlToFlutterPlatform _instance = MethodChannelHtmlToFlutter();

  /// The default instance of [HtmlToFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelHtmlToFlutter].
  static HtmlToFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HtmlToFlutterPlatform] when
  /// they register themselves.
  static set instance(HtmlToFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
