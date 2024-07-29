import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// Abstract class for parsing HTML content.
abstract class HtmlParserBase {
  HtmlParsed parse(String html);
}

final class HtmlParsed {
  /// The parsed HTML content.
  final List<HtmlItem> items;

  /// The original HTML content.
  final String source;

  /// Create a new parsed HTML content.
  const HtmlParsed(this.items, this.source);

  const HtmlParsed.empty()
      : items = const [],
        source = '';

  int get length => items.length;

  HtmlItem operator [](int index) => items[index];

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  /// Builds a widget with the given index.
  Widget buildWithIndex(BuildContext context, int index) =>
      items[index].buildWithIndex(context, index);
}
