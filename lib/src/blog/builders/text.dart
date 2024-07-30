import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogTextBuilder extends HtmlWidgetBuilder {
  const BlogTextBuilder(this.span);

  final InlineSpan span;

  @override
  factory BlogTextBuilder.fromNode(dom.Node node) {
    final span = _createRecurssiveSpan(node);
    return BlogTextBuilder(span);
  }

  static InlineSpan _createRecurssiveSpan(dom.Node node) {
    return switch (node) {
      (dom.Text text) => TextSpan(text: text.text),
      (dom.Element element) when element.localName == 'br' =>
        const TextSpan(text: '\n'),
      (dom.Element element) when element.localName != 'br' => (() {
          final children = element.nodes.map(_createRecurssiveSpan).toList();
          return TextSpan(children: children);
        })(),
      _ => throw UnimplementedError('Unsupported node type: $node'),
    };
  }

  static const List<String> tags = ['p', 'span'];

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16) ??
          const TextStyle(fontSize: 16),
      child: Text.rich(span),
    );
  }
}
