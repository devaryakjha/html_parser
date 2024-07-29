import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogParser implements HtmlParserBase {
  const BlogParser(this._input);

  final String _input;

  @override
  String get input => _input;

  @override
  HtmlParsed parse() => HtmlParsed(source: _input, items: const []);
}
