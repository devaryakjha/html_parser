import 'package:flutter/foundation.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:html_to_flutter/html_to_flutter.dart'
    show HtmlConfig, IHtmlParser, IHtmlWidget, IHtmlWidgetFactory;

/// {@template html_parser}
/// A parser for HTML content.
///
/// `config` is the configuration to use for parsing the HTML content.
///
/// see also:
/// [HtmlConfig].
///
///{@endtemplate}
final class HtmlParser implements IHtmlParser {
  /// Creates a new instance of [HtmlParser].
  ///
  /// {@macro html_parser}
  const HtmlParser(this._config);

  final HtmlConfig _config;

  @override
  HtmlConfig get config => _config;

  @override
  List<IHtmlWidgetFactory<IHtmlWidget>> parse(String html) {
    final nodes = _createNodes(html);
    final items = <IHtmlWidgetFactory<IHtmlWidget>>[];
    for (final node in nodes) {
      final factory = _createFactory(node, config);
      if (factory != null) {
        items.add(factory);
      }
    }
    return items;
  }

  /// Creates a factory for the given [node].
  IHtmlWidgetFactory<IHtmlWidget>? _createFactory(
    dom.Node node,
    HtmlConfig config,
  ) {
    if (node is dom.Text) {
      return config.getFactory('text')!(
        node,
        (node) => _createFactory(node, config),
      );
    }

    if (node is dom.Element) {
      final tag = node.localName;
      final factory = config.getFactory(tag);
      if (factory != null) {
        return factory(node, (node) => _createFactory(node, config));
      }
    }

    if (kDebugMode) {
      return IHtmlWidgetFactory.unsupported(node);
    }

    return null;
  }

  List<dom.Node> _createNodes(String html) {
    final document = parser.parse(html);
    return document.body?.nodes ?? [];
  }

  @override
  List<Object?> get props => [config];

  @override
  bool? get stringify => true;
}
