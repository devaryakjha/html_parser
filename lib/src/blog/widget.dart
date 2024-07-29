import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/blog.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

class HtmlBlogWidget extends StatefulWidget {
  const HtmlBlogWidget({super.key, required this.html});

  /// The HTML content to parse.
  final String html;

  @override
  State<HtmlBlogWidget> createState() => _HtmlBlogWidgetState();
}

class _HtmlBlogWidgetState extends State<HtmlBlogWidget> {
  late final BlogParser _parser;
  HtmlParsed _parsed = const HtmlParsed.empty();

  @override
  void initState() {
    super.initState();
    _parser = BlogParser();
    _parsed = _parser.parse(widget.html);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _parsed.length,
      itemBuilder: _parsed.buildWithIndex,
    );
  }
}
