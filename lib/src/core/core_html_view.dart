import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// A widget for displaying HTML content.
class Html extends StatefulWidget {
  /// Creates an HTML widget.
  Html(
    this.input, {
    super.key,
    HtmlConfig? config,
    final HtmlParser? parser,
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
    return HtmlConfigProvider(
      config: widget.config,
      child: ListView.builder(
        itemCount: parser.parse(input).length,
        itemBuilder: (context, index) {
          final factory = _widgetsFactories[index];
          return factory.builder(context);
        },
      ),
    );
  }
}
