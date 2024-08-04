import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as webview;
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render an [IframeHtmlWidget].
///
/// represents `<iframe>` tag.
final class IframeHtmlWidgetFactory implements IHtmlWidgetFactory {
  /// Creates a new instance of [IframeHtmlWidgetFactory].
  const IframeHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [IframeHtmlWidgetFactory] from a [HtmlNode].
  factory IframeHtmlWidgetFactory.fromNode(HtmlNode node) {
    final src = node.attributes['src'] ?? '';
    final width = double.tryParse(node.attributes['width'] ?? '');
    final height = double.tryParse(node.attributes['height'] ?? '');
    return IframeHtmlWidgetFactory(
      (context) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio:
              width != null && height != null ? width / height : 16 / 9,
          child: webview.InAppWebView(
            initialUrlRequest: webview.URLRequest(url: webview.WebUri(src)),
          ),
        ),
      ),
    );
  }

  final WidgetBuilder _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  WidgetBuilder get sliverBuilder => (context) => SliverToBoxAdapter(
        child: builder(context),
      );

  @override
  List<Object?> get props => [_builder];

  @override
  bool? get stringify => true;
}
