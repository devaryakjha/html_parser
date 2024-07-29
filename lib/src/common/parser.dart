import 'package:html_to_flutter/html_to_flutter.dart';

/// Abstract class for parsing HTML content.
abstract class HtmlParserBase<Result extends ParsedResultBase<D>,
    D extends HtmlWidgetBuilder> {
  /// Parses the given HTML content. Returns the parsed data.
  Result parse(String html);
}
