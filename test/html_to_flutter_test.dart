// import 'package:flutter_test/flutter_test.dart';
// import 'package:html_to_flutter/html_to_flutter_platform_interface.dart';
// import 'package:html_to_flutter/html_to_flutter_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockHtmlToFlutterPlatform
//     with MockPlatformInterfaceMixin
//     implements HtmlToFlutterPlatform {
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final HtmlToFlutterPlatform initialPlatform = HtmlToFlutterPlatform.instance;

//   test('$MethodChannelHtmlToFlutter is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelHtmlToFlutter>());
//   });

//   test('getPlatformVersion', () async {
//     MockHtmlToFlutterPlatform fakePlatform = MockHtmlToFlutterPlatform();
//     HtmlToFlutterPlatform.instance = fakePlatform;
//   });
// }
