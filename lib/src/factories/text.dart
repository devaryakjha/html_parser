import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

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

  /// Creates a new instance of [TextHtmlWidgetFactory] from a [HtmlNode].
  factory TextHtmlWidgetFactory.fromNode(
    HtmlNode node,
    UnsupportedParser unsupportedParser,
  ) {
    return TextHtmlWidgetFactory(
      (context) {
        final config = HtmlConfig.of(context);
        final styles = node is HtmlElement
            ? config.styles.getStyle(node.localName, config.defaultTextStyle)
            : null;
        final span =
            _createSpan(node, context, unsupportedParser) ?? const TextSpan();
        return TextHtmlWidget(
          span,
          source: node,
          styles: styles,
        );
      },
    );
  }

  final WidgetBuilder _builder;

  @override
  WidgetBuilder get builder => _builder;

  static TextSpan _createAnchor(
    HtmlElement node,
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
    HtmlNode node,
    BuildContext context,
    UnsupportedParser unsupportedParser, [
    GestureRecognizer? recognizer,
  ]) {
    final config = HtmlConfig.of(context);

    if (node is HtmlText) {
      final span = TextSpan(text: node.text, recognizer: recognizer);
      final shouldSkip =
          config.shouldSkipRenderingText?.call(span, node) ?? false;
      return shouldSkip ? null : span;
    }

    if (node is! HtmlElement) return null;

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

    if (node.isBreak) {
      const span = TextSpan(text: '\n');
      final shouldSkip =
          config.shouldSkipRenderingText?.call(span, node) ?? false;
      return shouldSkip ? null : span;
    }

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
    'tr',
    'td',
    'th',
    'tbody',
    'thead',
    'li',
  ];

  /// Creates a map of factories for the supported tags.
  static WidgetFactoryMap createFactoryMap() {
    return {
      for (final tag in tags) tag: TextHtmlWidgetFactory.fromNode,
    };
  }

  @override
  WidgetBuilder get sliverBuilder => (context) => SliverToBoxAdapter(
        child: _builder(context),
      );
}

extension on HtmlElement {
  /// Whether the element is a line break.
  bool get isBreak => localName == 'br';

  /// Whether the element is not supported.
  bool get isUnspported => !TextHtmlWidgetFactory.tags.contains(localName);

  /// Whether the element is a paragraph.
  bool get isAnchor => localName == 'a';
}
