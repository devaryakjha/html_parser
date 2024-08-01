import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as webview;
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render an `<iframe>` tag.
///
final class IframeHtmlWidget extends StatelessWidget implements IHtmlWidget {
  /// Creates a new instance of [IframeHtmlWidget].
  const IframeHtmlWidget({
    required this.src,
    super.key,
    this.width,
    this.height,
  });

  /// The source of the iframe.
  final String src;

  /// The width of the iframe.
  final double? width;

  /// The height of the iframe.
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
