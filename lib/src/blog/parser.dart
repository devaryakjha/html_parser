import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogParser
    extends HtmlParserBase<BlogParsedResult, HtmlWidgetBuilder> {
  const BlogParser(super.parsers);

  @override
  BlogParsedResult parse(String html) {
    throw UnimplementedError();
  }
}
