import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:html_to_flutter/html_to_flutter.dart' show IHtmlWidget;

/// An interface for creating instances of [IHtmlWidget].
abstract interface class IHtmlWidgetFactory {
  /// Creates a new instance of [IHtmlWidgetFactory].
  const IHtmlWidgetFactory();

  /// Creates a new instance of [HtmlWidget].
  Widget create<Widget extends IHtmlWidget>(
    final String html, {
    final String? sourceUrl,
  });

  /// Parses the given HTML content. Returns the parsed data.
  List<dom.Node> createNodes(final String html, {final String? sourceUrl}) {
    final parsed = parser.parse(html, sourceUrl: sourceUrl);
    final nodes = parsed.body?.nodes;
    return nodes ?? [];
  }
}
