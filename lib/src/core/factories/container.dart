import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:html_to_flutter/src/src.dart';

final class ContainerHtmlWidgetFactory
    implements IHtmlWidgetFactory<ContainerHtmlWidget> {
  const ContainerHtmlWidgetFactory(this._builder);

  static ContainerType _createContainerType(final dom.Node node) {
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

  factory ContainerHtmlWidgetFactory.fromNode(
    final dom.Node node,
    final UnsupportedParser unsupportedParser,
  ) {
    final children = node.nodes.map(unsupportedParser).whereNotNull().toList();
    return ContainerHtmlWidgetFactory((context) => ContainerHtmlWidget(
          children: children.map((e) => e.builder).toList(),
          type: _createContainerType(node),
        ));
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
