import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// Abstract class for parsing HTML content.
@immutable
abstract class HtmlParserBase<Result extends ParsedResultBase<D>,
    D extends HtmlWidgetBuilder> {
  const HtmlParserBase(this.parsers);

  final Map<String, D> parsers;

  /// Parses the given HTML content. Returns the parsed data.
  Result parse(String html);

  /// Registers a parser for the given tag.
  void register(String tag, D builder) {
    parsers[tag] = builder;
  }

  /// Registers parser for the given tags.
  void registerAll(List<String> tag, D builder) {
    for (var t in tag) {
      register(t, builder);
    }
  }

  /// Unregisters the parser for the given tag.
  void unregister(String tag) {
    parsers.remove(tag);
  }
}
