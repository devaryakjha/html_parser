import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

class HtmlWidget extends StatefulWidget {
  const HtmlWidget({
    super.key,
    required this.parser,
    required this.input,
  });

  final HtmlParserBase parser;

  final String input;

  @override
  State<HtmlWidget> createState() => _HtmlWidgetState();
}

class _HtmlWidgetState extends State<HtmlWidget> {
  late final ParsedResultBase result;
  @override
  void initState() {
    super.initState();
    result = widget.parser.parse(widget.input);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        final item = result[index];
        return item.build(context);
      },
    );
  }
}
