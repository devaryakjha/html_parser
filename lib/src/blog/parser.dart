import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogParser extends HtmlParserBase {
  const BlogParser({
    required super.input,
  }) : super(widgetFactories: WidgetFactories.defaulWidgetFactories);
}
