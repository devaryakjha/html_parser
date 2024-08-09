import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// A widget that displays a figure.
final class FigureExtension extends HtmlExtension {
  /// Creates a new instance of [FigureExtension].
  const FigureExtension();

  @override
  Set<String> get supportedTags => {'figure'};

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    final children = node.nodes
        .map((e) => ParsedResult.fromNode(e, config))
        .whereNotNull()
        .toList();
    return ParsedResult(
      children: children,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((e) => e.call(context, config)).toList(),
      ),
      source: node,
    );
  }
}
