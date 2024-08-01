import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class ListItemHtmlWidget extends StatelessWidget {
  final int index;
  final String title;
  final bool isOrdered;
  final dom.Node source;

  const ListItemHtmlWidget({
    super.key,
    required this.title,
    required this.index,
    this.isOrdered = false,
    required this.source,
  });

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
