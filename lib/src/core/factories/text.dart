import 'dart:developer';

import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class TextHtmlWidgetFactory
    implements IHtmlWidgetFactory<TextHtmlWidget> {
  const TextHtmlWidgetFactory(this._builder);

  final TextHtmlWidget Function(BuildContext) _builder;

  @override
  WidgetBuilder get builder => _builder;

  factory TextHtmlWidgetFactory.fromNode(
    final dom.Node node,
    final UnsupportedParser unsupportedParser,
  ) {
    return TextHtmlWidgetFactory(
      (context) =>
          TextHtmlWidget(_createSpan(node, context, unsupportedParser)!),
    );
  }

  static InlineSpan? _createSpan(
    final dom.Node node,
    final BuildContext context,
    final UnsupportedParser unsupportedParser,
  ) {
    if (node is dom.Text) {
      return TextSpan(text: node.text);
    }

    if (node is! dom.Element) return null;

    if (node.isUnspported) {
      return WidgetSpan(
        child: Builder(builder: (context) {
          final config = HtmlConfig.of(context);
          final child = unsupportedParser(node, config)?.builder(context);
          return child ?? Text('Unsupported tag: ${node.localName}');
        }),
      );
    }

    if (node.isAnchor) {
      return TextSpan(
        text: node.text,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            log('Tapped on anchor: ${node.attributes['href']}');
          },
      );
    }

    if (node.isBreak) return const TextSpan(text: '\n');

    final children = node.nodes
        .map((node) => _createSpan(node, context, unsupportedParser))
        .whereNotNull()
        .toList();

    return TextSpan(children: children);
  }

  @override
  List<Object?> get props => [builder];

  @override
  bool? get stringify => true;

  static const List<String> tags = [
    'a',
    'text',
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
    'br'
  ];
}

extension on dom.Element {
  /// Whether the element is a line break.
  bool get isBreak => localName == 'br';

  /// Whether the element is a paragraph.
  bool get isUnspported => !TextHtmlWidgetFactory.tags.contains(localName);

  /// Whether the element is a paragraph.
  bool get isAnchor => localName == 'a';
}
