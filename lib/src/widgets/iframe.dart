import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as webview;
import 'package:html_to_flutter/html_to_flutter.dart';

final class IframeHtmlWidget extends StatelessWidget implements IHtmlWidget {

  const IframeHtmlWidget({
    required this.src, super.key,
    this.width,
    this.height,
  });
  final String src;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio:
            width != null && height != null ? width! / height! : 16 / 9,
        child: webview.InAppWebView(
          initialUrlRequest: webview.URLRequest(url: webview.WebUri(src)),
        ),
      ),
    );
  }

  @override
  EdgeInsets? get margin => EdgeInsets.zero;

  @override
  EdgeInsets? get padding => EdgeInsets.zero;
}
