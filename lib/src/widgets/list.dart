import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to represent `ol` or `ul` elements.
///
/// This widget is used to render a list of items.
final class ListHtmlWidget extends StatelessWidget implements IHtmlWidget {
  /// Creates a new instance of [ListHtmlWidget].
  const ListHtmlWidget({
    required this.children,
    super.key,
    this.styles,
  });

  /// The [Styles] to use for the widget.
  final Styles? styles;

  /// The children to render.
  final List<ListItemHtmlWidget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: padding,
        shrinkWrap: true,
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }

  @override
  EdgeInsets get margin => styles?.margin ?? EdgeInsets.zero;

  @override
  EdgeInsets get padding => styles?.padding ?? EdgeInsets.zero;
}
