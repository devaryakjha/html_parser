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
  }) : renderSliver = false;

  /// Creates a new instance of [ListHtmlWidget] for sliver.
  const ListHtmlWidget.sliver({
    required this.children,
    super.key,
    this.styles,
  }) : renderSliver = true;

  /// The [Styles] to use for the widget.
  final Styles? styles;

  /// The children to render.
  final List<ListItemHtmlWidget> children;

  /// Whether to render as sliver.
  final bool renderSliver;

  @override
  Widget build(BuildContext context) {
    if (renderSliver) {
      return SliverPadding(
        padding: margin,
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) => children[i],
            childCount: children.length,
          ),
        ),
      );
    }
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
