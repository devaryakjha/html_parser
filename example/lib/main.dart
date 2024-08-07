import 'package:flutter/widgets.dart';

void main() {
  runApp(const WidgetsFromHtmlExample());
}

class WidgetsFromHtmlExample extends StatefulWidget {
  const WidgetsFromHtmlExample({super.key});

  @override
  State<WidgetsFromHtmlExample> createState() => _WidgetsFromHtmlExampleState();
}

class _WidgetsFromHtmlExampleState extends State<WidgetsFromHtmlExample> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
