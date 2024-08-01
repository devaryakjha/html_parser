import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:widgets_from_html/widgets_from_html.dart';

/// A factory that is used to render a [ListHtmlWidget].
///
/// represents `<ol>` and `<ul>` tags.
final class ListHtmlWidgetFactory
    implements IHtmlWidgetFactory<ListHtmlWidget> {
  /// Creates a new instance of [ListHtmlWidgetFactory].
  const ListHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [ListHtmlWidgetFactory] from a [dom.Node].
  factory ListHtmlWidgetFactory.fromNode(dom.Node node) {
    if (node is! dom.Element) {
      throw UnsupportedError(
        'ListHtmlWidgetFactory only supports dom.Element nodes',
      );
    }

    final isOrdered = node.localName == 'ol';

    return ListHtmlWidgetFactory(
      (context) {
        final config = HtmlConfig.of(context);
        return ListHtmlWidget(
          styles:
              config.styles.getStyle(node.localName, config.defaultTextStyle),
          children: node.nodes.whereType<dom.Element>().indexed.map((element) {
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
