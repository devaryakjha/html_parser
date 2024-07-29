import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom show Node;
import 'package:html/parser.dart' as parser;
import 'package:html_to_flutter/html_to_flutter.dart';

/// Abstract class for parsing HTML content.
abstract class HtmlParserBase {
  /// The input HTML content.
  final String input;

  /// The widget factories to use.
  final WidgetFactories widgetFactories;

  /// Create a new HTML parser.
  const HtmlParserBase({
    required this.input,
    this.widgetFactories = const BlogWidgetFactories(),
  });

  List<dom.Node> createNodes() {
    final parsed = parser.parse(input);
    final nodes = parsed.body?.nodes;
    return nodes ?? [];
  }

  /// Parse the HTML content.
  HtmlParsed parse() {
    final nodes = createNodes();
    final items = nodes.map(widgetFactories.create).toList();
    return HtmlParsed(items: items, source: input);
  }
}

@immutable
final class HtmlParsed {
  /// The parsed HTML content.
  final List<HtmlItem> items;

  /// The original HTML content.
  final String source;

  /// Create a new parsed HTML content.
  const HtmlParsed({required this.items, required this.source});

  const HtmlParsed.empty()
      : items = const [],
        source = '';

  int get length => items.length;

  /// Returns the item at the given index.
  HtmlItem operator [](int index) => items[index];

  /// Whether this collection has no elements
  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  /// Builds a widget with the given index.
  Widget buildWithIndex(BuildContext context, int index) =>
      items[index].buildWithIndex(context, index);
}
