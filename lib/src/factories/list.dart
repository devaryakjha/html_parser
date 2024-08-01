import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A factory that is used to render a [ListHtmlWidget].
///
/// represents `<ol>` and `<ul>` tags.
final class ListHtmlWidgetFactory
    implements IHtmlWidgetFactory<ListHtmlWidget> {
  /// Creates a new instance of [ListHtmlWidgetFactory].
  const ListHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [ListHtmlWidgetFactory] from a [HtmlNode].
  factory ListHtmlWidgetFactory.fromNode(HtmlNode node) {
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
          children: node.nodes.whereType<HtmlElement>().indexed.map((element) {
            final (index, node) = element;
            return ListItemHtmlWidget(
              title: node.text,
              index: index,
              isOrdered: isOrdered,
              source: node,
            );
          }).toList(),
        );
      },
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
