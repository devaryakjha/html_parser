import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

class HtmlWidget extends StatelessWidget {
  const HtmlWidget({
    super.key,
    required this.parser,
    required this.input,
  });

  final HtmlParserBase parser;

  final String input;

  @override
  Widget build(BuildContext context) {
    final result = parser.parse(input);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: result.length,
      itemBuilder: (context, index) {
        final item = result[index];
        return item.build(context);
      },
    );
  }
}
