import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render an [IframeHtmlWidget].
///
/// represents `<iframe>` tag.
final class IframeHtmlWidgetFactory
    implements IHtmlWidgetFactory<IframeHtmlWidget> {
  /// Creates a new instance of [IframeHtmlWidgetFactory].
  const IframeHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [IframeHtmlWidgetFactory] from a [HtmlNode].
  factory IframeHtmlWidgetFactory.fromNode(HtmlNode node) {
    final src = node.attributes['src'] ?? '';
    final width = double.tryParse(node.attributes['width'] ?? '');
    final height = double.tryParse(node.attributes['height'] ?? '');
    return IframeHtmlWidgetFactory(
      (context) => IframeHtmlWidget(
        src: src,
        width: width,
        height: height,
      ),
    );
  }

  final WidgetBuilder _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [_builder];

  @override
  bool? get stringify => true;
}
