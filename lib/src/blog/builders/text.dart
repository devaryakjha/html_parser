import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogTextBuilder extends HtmlWidgetBuilder {
  const BlogTextBuilder(this.span);

  final InlineSpan span;

  @override
  factory BlogTextBuilder.fromNode(dom.Node node) {
    return const BlogTextBuilder(TextSpan(text: ''));
  }

  static const List<String> tags = ['p', 'span'];

  @override
  Widget build(BuildContext context) {
    return Text.rich(span);
  }
}
