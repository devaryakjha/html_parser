import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// A widget for displaying HTML content.
class Html extends StatelessWidget {
  /// Creates an HTML widget.
  Html({
    super.key,
    this.config = const HtmlConfig(),
    final HtmlParser? parser,
  }) : parser = parser ?? HtmlParser(config);

  /// The configuration for the HTML widget.
  final HtmlConfig config;

  /// The parser to use for parsing the HTML string.
  final IHtmlParser parser;

  @override
  Widget build(BuildContext context) {
    return HtmlConfigProvider(
      config: config,
      child: const Placeholder(),
    );
  }
}
