import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class TextHtmlWidgetFactory
    implements IHtmlWidgetFactory<TextHtmlWidget> {
  const TextHtmlWidgetFactory(this._builder);

  final TextHtmlWidget Function(BuildContext) _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  factory TextHtmlWidgetFactory.fromNode(final dom.Node node) {
    return TextHtmlWidgetFactory(
      (context) => TextHtmlWidget(_createSpan(node, context)!),
    );
  }

  static InlineSpan? _createSpan(
    final dom.Node node,
    final BuildContext context,
  ) {
    if (node is dom.Text) {
      return TextSpan(text: node.text);
    }

    if (node is! dom.Element) return null;

    final children = node.nodes
        .map((node) => _createSpan(node, context))
        .whereNotNull()
        .toList();

    return TextSpan(children: children);
  }

  @override
  List<Object?> get props => [builder];

  @override
  bool? get stringify => true;

  static const List<String> tags = [
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

extension on dom.Element {}
