import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:html_to_flutter/src/src.dart';

final class ContainerHtmlWidgetFactory
    implements IHtmlWidgetFactory<ContainerHtmlWidget> {
  const ContainerHtmlWidgetFactory(this._builder);

  factory ContainerHtmlWidgetFactory.fromNode(
    final dom.Node node,
    final UnsupportedParser unsupportedParser,
  ) {
    final children = node.nodes.map(unsupportedParser).whereNotNull().toList();
    return ContainerHtmlWidgetFactory((context) {
      return ContainerHtmlWidget(
        children: children.map((e) => e.builder).toList(),
      );
    });
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
