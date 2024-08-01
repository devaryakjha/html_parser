import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';
import 'package:widgets_from_html_example/utils/blog_config.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({
    super.key,
    required this.input,
    required this.title,
  });

  final String input;

  final String title;

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        surfaceTintColor: Colors.black,
        scrolledUnderElevation: 10,
      ),
      body: Html(
        widget.input,
        config: BlogConfig(),
      ),
    );
  }
}
