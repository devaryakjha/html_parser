import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:meta/meta.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart'
    show HTMLElement, HtmlConfig, NodeList, ParsedResult, parseHtml;

/// Parser for HTML content.
@immutable
@visibleForTesting
final class Parser {
  /// Creates a [Parser].
  const Parser({
    required this.config,
  });

  /// The config for parsing HTML.
  final HtmlConfig config;

  /// Parses the HTML content.
  List<ParsedResult> parse(String data) {
    final nodes = _toNodeList(data);

    /// If None, return an empty list.
    if (nodes == null) return [];

    final result = nodes
        .whereType<HTMLElement>()
        .map((node) => ParsedResult.fromNode(node, config))
        .whereNotNull()
        .toList();

    return result;
  }

  /// Parses the String `data` and returns a [NodeList].
  NodeList? _toNodeList(String data) {
    final document = parseHtml(data);
    return document.body?.nodes;
  }
}
