import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget for displaying HTML content.
class Html extends StatefulWidget {
  /// Creates an HTML widget.
  Html(
    this.input, {
    super.key,
    HtmlConfig? config,
    HtmlParser? parser,
  })  : config = config ?? HtmlConfig(),
        parser = parser ?? HtmlParser(config ?? HtmlConfig());

  /// The configuration for the HTML widget.
  final HtmlConfig config;

  /// The parser to use for parsing the HTML string.
  final IHtmlParser parser;

  /// The HTML string to display.
  final String input;

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  String get input => widget.input;
  IHtmlParser get parser => widget.parser;

  late final List<IHtmlWidgetFactory> _widgetsFactories;

  void _initialise() {
    _widgetsFactories = parser.parse(input);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initialise();
  }

  @override
  Widget build(BuildContext context) {
    final factories = kDebugMode ? parser.parse(input) : _widgetsFactories;
    return DefaultTextStyle(
      style: widget.config.defaultTextStyle,
      child: HtmlConfigProvider(
        config: widget.config,
        child: Builder(
          builder: (context) {
            final isSingle = factories.length == 1;
            if (isSingle) {
              final factory = factories.single;
              return factory.builder(context);
            }
            return ListView.builder(
              primary: false,
              padding: EdgeInsets.zero,
              itemCount: factories.length,
              itemBuilder: (context, index) {
                final factory = factories[index];
                return factory.builder(context);
              },
            );
          },
        ),
      ),
    );
  }
}
