import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

/// A widget that is used to render a list item.
///
/// represents `<li>` tag.
final class ListItemHtmlWidget extends StatelessWidget {
  /// Creates a new instance of [ListItemHtmlWidget].
  const ListItemHtmlWidget({
    required this.title,
    required this.index,
    required this.source,
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
  final dom.Node source;

  @override
  Widget build(BuildContext context) {
    final config = HtmlConfig.of(context);
    final style = config.styles.getStyle('li', config.defaultTextStyle);
    final childrenSpans = source.nodes.whereType<dom.Element>().map((element) {
      return TextSpan(
        text: element.text,
        style: config.styles
            .getStyle(element.localName, config.defaultTextStyle)
            ?.textStyle,
      );
    }).toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isOrdered) Text('${index + 1}.  '),
        if (!isOrdered) const Text('• '),
        Expanded(
          child: TextHtmlWidget(
            TextSpan(
              text: childrenSpans.isEmpty ? source.text : null,
              children: childrenSpans,
              style: style?.textStyle,
            ),
          ),
        ),
      ],
    );
  }
}
