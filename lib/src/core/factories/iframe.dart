import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class IframeHtmlWidgetFactory
    implements IHtmlWidgetFactory<IframeHtmlWidget> {
  const IframeHtmlWidgetFactory(this._builder);

  factory IframeHtmlWidgetFactory.fromNode(
    final dom.Node node,
    final UnsupportedParser unsupported,
  ) {
    final src = node.attributes['src'] ?? '';
    final width = double.tryParse(node.attributes['width'] ?? '');
    final height = double.tryParse(node.attributes['height'] ?? '');
    return IframeHtmlWidgetFactory(
      (context) => IframeHtmlWidget(
        src: src,
        width: width,
        height: height,
      ),
    );
  }

  final WidgetBuilder _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [_builder];

  @override
  bool? get stringify => true;
}
