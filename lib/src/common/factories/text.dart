part of 'factories.dart';

final class TextFactory implements WidgetFactory {
  const TextFactory();

  @override
  HtmlItem create(dom.Node node) {
    return HtmlTextItem(span: TextSpan(text: node.text));
  }

  @override
  List<String> get tags => [
        'p',
        'span',
        'h1',
        'h2',
        'h3',
        'h4',
        'h5',
        'h6',
        'strong',
        'em',
        'b',
        'i',
        'u',
        's',
        'sub',
        'sup',
      ];
}
