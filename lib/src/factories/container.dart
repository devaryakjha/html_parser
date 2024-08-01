import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:widgets_from_html/widgets_from_html.dart';

/// A factory for creating a [ContainerHtmlWidget].
final class ContainerHtmlWidgetFactory
    implements IHtmlWidgetFactory<ContainerHtmlWidget> {
  /// Creates a new instance of [ContainerHtmlWidgetFactory].
  const ContainerHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [ContainerHtmlWidgetFactory] from a [dom.Node].
  factory ContainerHtmlWidgetFactory.fromNode(
    dom.Node node,
    UnsupportedParser unsupportedParser,
  ) {
    final children = node.nodes.map(unsupportedParser).whereNotNull().toList();
    return ContainerHtmlWidgetFactory(
      (context) => ContainerHtmlWidget(
        children: children.map((e) => e.builder).toList(),
        type: _createContainerType(node),
      ),
    );
  }

  static ContainerType _createContainerType(dom.Node node) {
    final classses = node.attributes['class'];
    final styles = node.attributes['style'];

    return classses?.contains('row') ??
            classses?.contains('flex-row') ??
            classses?.contains('flex-row-reverse') ??
            styles?.contains('display: flex;') ??
            styles?.contains('flex-direction: row;') ??
            styles?.contains('flex-direction: row-reverse;') ??
            false
        ? ContainerType.row
        : ContainerType.column;
  }

  /// The [WidgetBuilder] to use for the widget.
  final WidgetBuilder _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [_builder];

  @override
  bool? get stringify => true;
}
