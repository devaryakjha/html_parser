import 'package:equatable/equatable.dart';
import 'package:html_to_flutter/html_to_flutter.dart'
    show HtmlConfig, IHtmlWidget, IHtmlWidgetFactory;

/// An interface for parsing HTML strings.
abstract interface class IHtmlParser with EquatableMixin {

  const IHtmlParser({required this.config});
  final HtmlConfig config;

  /// Parses the given [html] string and returns a list of [IHtmlWidget]s.
  List<IHtmlWidgetFactory> parse(final String html);
}
