import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:html_to_flutter/html_to_flutter.dart';

/// Abstract class for parsing HTML content.
@immutable
abstract class HtmlParserBase<Result extends ParsedResultBase<D>,
    D extends HtmlWidgetBuilder> {
  const HtmlParserBase();

  Map<String, D Function(dom.Node)> get parsers;

  /// Creates a list of nodes from the given HTML content.
  List<dom.Node> createNodes(String html) {
    final parsed = parser.parse(html);
    final nodes = parsed.body?.nodes;
    return nodes ?? [];
  }

  /// Parse the nodes and return a list of [D]s.
  List<D> parseNodes(List<dom.Node> nodes);

  /// Parses the given HTML content. Returns the parsed data.
  Result parse(String html);

  /// Registers a parser for the given tag.
  void register(String tag, D Function(dom.Node) builder) {
    parsers[tag] = builder;
  }

  /// Registers parser for the given tags.
  void registerAll(List<String> tag, D Function(dom.Node) builder) {
    for (var t in tag) {
      register(t, builder);
    }
  }

  /// Unregisters the parser for the given tag.
  void unregister(String tag) {
    parsers.remove(tag);
  }
}
