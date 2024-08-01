import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class ListHtmlWidgetFactory
    implements IHtmlWidgetFactory<ListHtmlWidget> {
  const ListHtmlWidgetFactory(this._builder);

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
