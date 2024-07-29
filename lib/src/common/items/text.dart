import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

final class HtmlTextItem extends HtmlItem {
  const HtmlTextItem({
    super.key,
    required this.span,
  });

  final InlineSpan span;

  @override
  Widget build(BuildContext context) {
    return Text.rich(span);
  }

  @override
  Widget buildWithIndex(BuildContext context, int index) {
    return build(context);
  }
}
