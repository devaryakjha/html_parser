import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

///  A factory for creating instances of [FigureHtmlWidgetFactory].
///
final class FigureHtmlWidgetFactory
    implements IHtmlWidgetFactory<FigureHtmlWidget> {
  /// Creates a new instance of [FigureHtmlWidgetFactory].
  const FigureHtmlWidgetFactory(this._builder, this._sliverBuilder);

  /// Creates a new instance of [FigureHtmlWidgetFactory] from a [HtmlNode].
  factory FigureHtmlWidgetFactory.fromNode(
    HtmlNode node,
    UnsupportedParser unsupportedParser,
  ) {
    final children = node.nodes.map(unsupportedParser).whereNotNull().toList();
    return FigureHtmlWidgetFactory(
      (context) {
        final config = HtmlConfig.of(context);
        final styles = node is HtmlElement
            ? config.styles.getStyle(node.localName, config.defaultTextStyle)
            : null;

        return FigureHtmlWidget(
          style: styles,
          children: children.map((e) => e.builder).toList(),
        );
      },
      (context) {
        final config = HtmlConfig.of(context);
        final styles = node is HtmlElement
            ? config.styles.getStyle(node.localName, config.defaultTextStyle)
            : null;

        return FigureHtmlWidget.sliver(
          style: styles,
          children: children.map((e) => e.builder).toList(),
        );
      },
    );
  }

  final WidgetBuilder _builder;

  final WidgetBuilder _sliverBuilder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  WidgetBuilder get sliverBuilder => _sliverBuilder;

  @override
  List<Object?> get props => [_builder];

  @override
  bool? get stringify => true;
}
