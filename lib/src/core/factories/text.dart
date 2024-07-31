import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class TextHtmlWidgetFactory
    implements IHtmlWidgetFactory<TextHtmlWidget> {
  const TextHtmlWidgetFactory(this._builder);

  final TextHtmlWidget Function(BuildContext) _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  factory TextHtmlWidgetFactory.fromNode(final dom.Node node) {
    return TextHtmlWidgetFactory(
        (context) => TextHtmlWidget(TextSpan(text: node.text)));
  }

  @override
  List<Object?> get props => [builder];

  @override
  bool? get stringify => true;

  static const List<String> tags = [
    'p',
    'h1',
    'h2',
    'h3',
    'h4',
    'h5',
    'h6',
    'span',
    'sup',
    'sub'
  ];
}
