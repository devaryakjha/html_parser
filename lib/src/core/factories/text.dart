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
      (context) {
        final config = HtmlConfig.of(context);
        final styles = node is dom.Element
            ? config.styles.getStyle(node.localName, config.defaultTextStyle)
            : null;

        return TextHtmlWidget(
          _createSpan(node, context, unsupportedParser)!,
          styles: styles,
        );
      },
    );
  }

  static TextSpan _createAnchor(
    final dom.Element node,
    final BuildContext context,
    final UnsupportedParser unsupportedParser,
  ) {
    final config = HtmlConfig.of(context);
    final recogniser = config.onLinkTap != null
        ? (TapGestureRecognizer()
          ..onTap = () {
            final href = node.attributes['href'];
            config.onLinkTap?.call(href);
          })
        : null;
    final style =
        config.styles.getStyle(node.localName, config.defaultTextStyle);
    final children = node.nodes
        .map((node) {
          return _createSpan(node, context, unsupportedParser, recogniser);
        })
        .whereNotNull()
        .toList();
    return TextSpan(
      text: children.isEmpty ? node.text : null,
      recognizer: children.isEmpty ? recogniser : null,
      style: style?.textStyle,
      children: children,
    );
  }

  static Widget _wrapInGestureDetectorIfNeed(
    final Widget child,
    final GestureRecognizer? recognizer,
  ) {
    if (recognizer is TapGestureRecognizer) {
      return GestureDetector(
        onTap: recognizer.onTap,
        child: child,
      );
    }
    return child;
  }

  static InlineSpan? _createSpan(
    final dom.Node node,
    final BuildContext context,
    final UnsupportedParser unsupportedParser, [
    final GestureRecognizer? recognizer,
  ]) {
    final config = HtmlConfig.of(context);

    if (node is dom.Text) {
      return TextSpan(text: node.text, recognizer: recognizer);
    }

    if (node is! dom.Element) return null;

    final style =
        config.styles.getStyle(node.localName, config.defaultTextStyle);

    if (node.isUnspported) {
      return WidgetSpan(
        child: Builder(builder: (context) {
          final child = unsupportedParser(node, config)?.builder(context);
          return _wrapInGestureDetectorIfNeed(
            child ?? Text('Unsupported tag: ${node.localName}'),
            recognizer,
          );
        }),
        style: style?.textStyle,
      );
    }

    if (node.isBreak) return const TextSpan(text: '\n');

    if (node.isAnchor) {
      return _createAnchor(node, context, unsupportedParser);
    }

    final children = node.nodes
        .map((node) {
          return _createSpan(node, context, unsupportedParser, recognizer);
        })
        .whereNotNull()
        .toList();

    return TextSpan(
      children: children,
      style: style?.textStyle,
      recognizer: recognizer,
    );
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
