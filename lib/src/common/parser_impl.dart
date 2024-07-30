import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class HtmlParser extends HtmlParserBase<ParsedResult, HtmlWidgetBuilder> {
  const HtmlParser();

  @override
  Map<String, HtmlWidgetBuilder Function(dom.Node)> get parsers {
    return Map.fromEntries([
      ...HtmlTextBuilder.tags.map((t) => MapEntry(t, HtmlTextBuilder.fromNode)),
    ]);
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
        items.add(HtmlTextBuilder.fromNode(node));
      }
    }
    return items;
  }

  @override
  ParsedResult parse(String html) {
    final nodes = createNodes(html);
    final builders = parseNodes(nodes);
    return ParsedResult(builders, source: html);
  }
}
