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
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        surfaceTintColor: Colors.black,
        scrolledUnderElevation: 10,
      ),
      body: Html(input),
    );
  }
}
