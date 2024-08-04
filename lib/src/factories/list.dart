import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A factory that is used to render a [ListHtmlWidget].
///
/// represents `<ol>` and `<ul>` tags.
final class ListHtmlWidgetFactory
    implements IHtmlWidgetFactory<ListHtmlWidget> {
  /// Creates a new instance of [ListHtmlWidgetFactory].
  const ListHtmlWidgetFactory(this._builder, this._sliverBuilder);

  /// Creates a new instance of [ListHtmlWidgetFactory] from a [HtmlNode].
  factory ListHtmlWidgetFactory.fromNode(
    HtmlNode node,
    UnsupportedParser unsupportedParser,
  ) {
    if (node is! HtmlElement) {
      throw UnsupportedError(
        'ListHtmlWidgetFactory only supports HtmlElement nodes',
      );
    }

    final isOrdered = node.localName == 'ol';

    return ListHtmlWidgetFactory(
      (context) {
        final config = HtmlConfig.of(context);
        return ListHtmlWidget(
          styles:
              config.styles.getStyle(node.localName, config.defaultTextStyle),
          children: node.nodes.whereType<HtmlElement>().map((node) {
            return (BuildContext context, int index) {
              return ListItemHtmlWidget(
                title: node.text,
                index: index,
                isOrdered: isOrdered,
                source: node,
                unsupportedParser: unsupportedParser,
              );
            };
          }).toList(),
        );
      },
      (context) {
        final config = HtmlConfig.of(context);
        return ListHtmlWidget.sliver(
          styles:
              config.styles.getStyle(node.localName, config.defaultTextStyle),
          children: node.nodes.whereType<HtmlElement>().map((node) {
            return (BuildContext context, int index) {
              return ListItemHtmlWidget(
                title: node.text,
                index: index,
                isOrdered: isOrdered,
                source: node,
                unsupportedParser: unsupportedParser,
              );
            };
          }).toList(),
        );
      },
    );
  }

  final WidgetBuilder _builder;

  final WidgetBuilder _sliverBuilder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  WidgetBuilder get sliverBuilder => _sliverBuilder;

  @override
  List<Object?> get props => [_builder];

  @override
  bool? get stringify => true;
}
