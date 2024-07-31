import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:html_to_flutter/html_to_flutter.dart'
    show IHtmlWidget, IHtmlWidgetFactory, IHtmlParser, HtmlConfig;

final class HtmlParser implements IHtmlParser {
  const HtmlParser(this._config);

  final HtmlConfig _config;

  @override
  HtmlConfig get config => _config;

  @override
  List<IHtmlWidgetFactory<IHtmlWidget>> parse(String html) {
    final nodes = _createNodes(html);
    final items = <IHtmlWidgetFactory<IHtmlWidget>>[];
    for (final node in nodes) {
      items.addAll(createFactoryRecursive(node));
    }
    return items;
  }

  List<IHtmlWidgetFactory<IHtmlWidget>> createFactoryRecursive(dom.Node node) {
    final factories = <IHtmlWidgetFactory<IHtmlWidget>>[];
    final factory = _createFactory(node);
    if (factory != null) {
      factories.add(factory);
    }
    for (final child in node.nodes) {
      factories.addAll(createFactoryRecursive(child));
    }
    return factories;
  }

  IHtmlWidgetFactory<IHtmlWidget>? _createFactory(dom.Node node) {
    if (node is dom.Element) {
      final tag = node.localName;
      final factory = config.customFactories[tag] ?? config.factories[tag];
      if (factory != null) {
        return factory(node);
      }
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
