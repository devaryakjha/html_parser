import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogParser
    extends HtmlParserBase<BlogParsedResult, HtmlWidgetBuilder> {
  const BlogParser();

  @override
  Map<String, HtmlWidgetBuilder Function(dom.Node)> get parsers {
    return Map.fromEntries([
      ...BlogTextBuilder.tags.map((t) => MapEntry(t, BlogTextBuilder.fromNode)),
    ]);
  }

  @override
  BlogParsedResult parse(String html) {
    final nodes = createNodes(html);
    final parsed = parseNodes(nodes);
    return BlogParsedResult(parsed, source: html);
  }

  @override
  List<HtmlWidgetBuilder> parseNodes(List<dom.Node> nodes) {
    final items = <HtmlWidgetBuilder>[];
    for (var node in nodes) {
      if (node is dom.Element) {
        final tag = node.localName;
        final builder = parsers[tag];
        if (builder != null) {
          items.add(builder(node));
        }
      } else if (node is dom.Text) {
        items.add(BlogTextBuilder.fromNode(node));
      }
    }
    return items;
  }
}
