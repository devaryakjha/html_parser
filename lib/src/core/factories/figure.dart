import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class FigureHtmlWidgetFactory
    implements IHtmlWidgetFactory<FigureHtmlWidget> {
  const FigureHtmlWidgetFactory(this._builder, [this.children = const []]);

  final WidgetBuilder _builder;

  final List<IHtmlWidgetFactory> children;

  factory FigureHtmlWidgetFactory.fromNode(
    final dom.Node node,
    final UnsupportedParser unsupportedParser,
  ) {
    final children = node.nodes.map(unsupportedParser).whereNotNull().toList();
    return FigureHtmlWidgetFactory(
      (context) {
        final config = HtmlConfig.of(context);
        final styles = node is dom.Element
            ? config.styles.getStyle(node.localName, config.defaultTextStyle)
            : null;

        return FigureHtmlWidget(
          style: styles,
        );
      },
      children,
    );
  }

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [_builder];

  @override
  bool? get stringify => true;
}
