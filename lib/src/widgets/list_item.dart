import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render a list item.
///
/// represents `<li>` tag.
final class ListItemHtmlWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final config = HtmlConfig.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isOrdered) Text('${index + 1}.  '),
        if (!isOrdered) const Text('• '),
        Expanded(
          child: config
              .getFactory('text')!(
                HtmlElement.tag('text')..nodes.addAll(source.nodes),
                unsupportedParser,
              )
              .builder(context),
        ),
      ],
    );
  }
}
