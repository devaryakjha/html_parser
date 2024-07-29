import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

final class HtmlSupportedItem extends HtmlItem {
  const HtmlSupportedItem({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Text('Unsupported tag: $tag');
  }

  @override
  Widget buildWithIndex(BuildContext context, int index) {
    return build(context);
  }
}
