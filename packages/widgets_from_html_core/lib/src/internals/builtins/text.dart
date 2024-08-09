import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// A widget that displays a text.
final class TextExtension extends HtmlExtension {
  /// Creates a new instance of [TextExtension].
  const TextExtension();

  @override
  bool isNodeSupported(Node node) {
    return node is HTMLText || super.isNodeSupported(node);
  }

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    if (!isNodeSupported(node)) return null;

    if (node is HTMLText) {
      return _fromText(node, config);
    }

    if (node is HTMLElement) {
      return _fromElement(node, config);
    }

    return null;
  }

  ParsedResult _fromText(HTMLText e, HtmlConfig config) {
    return ParsedResult(
      builder: (context) {
        var input = e.data;
        if (input.startsWith('\n')) {
          input = input.substring(1);
        }
        return Text(input);
      },
      source: e,
    );
  }

  ParsedResult _fromElement(HTMLElement e, HtmlConfig config) {
    final spans = e.nodes
        .map((node) => _createSpanForNodeRecurssively(node, config))
        .whereNotNull()
        .toList();
    return ParsedResult(
      builder: (context) => Text.rich(TextSpan(children: spans)),
      source: e,
    );
  }

  InlineSpan? _createSpanForNodeRecurssively(Node node, HtmlConfig config) {
    if (!isNodeSupported(node)) {
      final result = ParsedResult.fromNode(node, config);
      if (result == null) return null;
      return WidgetSpan(
        child: Builder(builder: (context) => result.call(context, config)),
      );
    }

    if (node is HTMLText) {
      return TextSpan(text: node.text);
    }

    if (node is HTMLElement) {
      return _createSpanForElement(node, config);
    }

    return null;
  }

  InlineSpan _createSpanForElement(HTMLElement e, HtmlConfig config) {
    if (e.localName == 'br') return const TextSpan(text: '\n');
    final children = e.nodes
        .map((node) => _createSpanForNodeRecurssively(node, config))
        .whereNotNull()
        .toList();
    return TextSpan(
      children: children,
    );
  }

  @override
  Set<String> get supportedTags => {
        'text',
        'a',
        'p',
        'h1',
        'h2',
        'h3',
        'h4',
        'h5',
        'h6',
        'span',
        'sup',
        'sub',
        'b',
        'strong',
        'i',
        'em',
        'br',
        'tr',
        'td',
        'th',
        'tbody',
        'thead',
        'li',
      };
}
