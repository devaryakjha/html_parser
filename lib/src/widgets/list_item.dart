import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render a list item.
///
/// represents `<li>` tag.
final class ListItemHtmlWidget extends StatefulWidget {
  /// Creates a new instance of [ListItemHtmlWidget].
  const ListItemHtmlWidget({
    required this.title,
    required this.index,
    required this.source,
    required this.unsupportedParser,
    super.key,
    this.isOrdered = false,
  });

  /// The index of the list item.
  final int index;

  /// The title of the list item.
  final String title;

  /// Whether the list is ordered.
  final bool isOrdered;

  /// The source of the list item.
  final HtmlNode source;

  /// The unsupported parser.
  final UnsupportedParser unsupportedParser;

  @override
  State<ListItemHtmlWidget> createState() => _ListItemHtmlWidgetState();
}

class _ListItemHtmlWidgetState extends State<ListItemHtmlWidget> {
  @override
  Widget build(BuildContext context) {
    final child = HtmlConfig.of(context)
        .getFactory('text')!(widget.source, widget.unsupportedParser)
        .builder(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isOrdered) Text('${widget.index + 1}.  '),
        if (!widget.isOrdered) const Text('• '),
        Expanded(child: child),
      ],
    );
  }
}
