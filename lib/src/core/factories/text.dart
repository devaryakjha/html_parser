import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class TextHtmlWidgetFactory
    implements IHtmlWidgetFactory<TextHtmlWidget> {
  const TextHtmlWidgetFactory(this._widget);

  final TextHtmlWidget _widget;

  @override
  TextHtmlWidget get widget => _widget;

  @override
  factory TextHtmlWidgetFactory.fromNode(final dom.Node node) {
    return TextHtmlWidgetFactory(TextHtmlWidget(TextSpan(text: node.text)));
  }
}
