import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

/// A factory for creating instances of [TextHtmlWidgetFactory].
///
/// represents `<text>`, `<p>`, `<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`, `<h6>`,
/// `<span>`, `<sup>`, `<sub>`, `<b>`, `<strong>`, `<i>`, `<em>`, `<br>`, `<a>`,
/// `<table>`, `<tr>`, `<td>`, `<th>`, `<tbody>`, `<thead>` tags.
///
///
final class TextHtmlWidgetFactory
    implements IHtmlWidgetFactory<TextHtmlWidget> {
  /// Creates a new instance of [TextHtmlWidgetFactory].
  const TextHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [TextHtmlWidgetFactory] from a [dom.Node].
  factory TextHtmlWidgetFactory.fromNode(
    dom.Node node,
    UnsupportedParser unsupportedParser,
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

  final TextHtmlWidget Function(BuildContext) _builder;

  @override
  WidgetBuilder get builder => _builder;

  static TextSpan _createAnchor(
    dom.Element node,
    BuildContext context,
    UnsupportedParser unsupportedParser,
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
        .map((_) => _createSpan(_, context, unsupportedParser, recogniser))
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
    Widget child,
    GestureRecognizer? recognizer,
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
    dom.Node node,
    BuildContext context,
    UnsupportedParser unsupportedParser, [
    GestureRecognizer? recognizer,
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
        child: Builder(
          builder: (context) {
            final child = unsupportedParser(node)?.builder(context);
            return _wrapInGestureDetectorIfNeed(
              child ?? Text('Unsupported tag: ${node.localName}'),
              recognizer,
            );
          },
        ),
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

  /// The list of supported tags.
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
    'br',
    // table
    'tr',
    'td',
    'th',
    'tbody',
    'thead',
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
