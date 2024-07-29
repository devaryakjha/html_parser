import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

class HtmlWidget extends StatefulWidget {
  const HtmlWidget({
    super.key,
    required this.parser,
  });

  final HtmlParserBase parser;

  @override
  State<HtmlWidget> createState() => _HtmlWidgetState();
}

class _HtmlWidgetState extends State<HtmlWidget> {
  late final HtmlParsed _parsed;

  @override
  void initState() {
    super.initState();
    _parsed = widget.parser.parse();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _parsed.length,
      itemBuilder: (context, index) => _parsed.buildWithIndex(context, index),
    );
  }
}
