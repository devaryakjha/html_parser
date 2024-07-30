import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({
    super.key,
    required this.input,
    required this.title,
  });

  final String input;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: HtmlWidget(
        parser: const HtmlParser(),
        input: input,
      ),
    );
  }
}
