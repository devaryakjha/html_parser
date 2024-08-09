import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

@internal
final class HtmlList extends StatelessWidget {
  const HtmlList({
    required this.children,
    required this.config,
    required this.padding,
    super.key,
  });

  final List<Widget> children;

  final HtmlConfig config;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
