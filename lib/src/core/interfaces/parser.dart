import 'package:equatable/equatable.dart';
import 'package:html_to_flutter/html_to_flutter.dart'
    show IHtmlWidgetFactory, IHtmlWidget, HtmlConfig;

/// An interface for parsing HTML strings.
abstract interface class IHtmlParser with EquatableMixin {
  final HtmlConfig config;

  const IHtmlParser({required this.config});

  /// Parses the given [html] string and returns a list of [IHtmlWidget]s.
  List<IHtmlWidgetFactory> parse(final String html);
}
