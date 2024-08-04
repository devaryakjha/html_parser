import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to represent `ol` or `ul` elements.
///
/// This widget is used to render a list of items.
final class ListHtmlWidget extends StatelessWidget with IHtmlWidget {
  /// Creates a new instance of [ListHtmlWidget].
  const ListHtmlWidget({
    required this.children,
    super.key,
    Styles? styles,
  })  : _styles = styles,
        renderSliver = false;

  /// Creates a new instance of [ListHtmlWidget] for sliver.
  const ListHtmlWidget.sliver({
    required this.children,
    super.key,
    Styles? styles,
  })  : _styles = styles,
        renderSliver = true;

  /// The [Styles] to use for the widget.
  final Styles? _styles;

  @override
  Styles get styles => _styles ?? super.styles;

  /// The children to render.
  final List<IndexedWidgetBuilder> children;

  /// Whether to render as sliver.
  final bool renderSliver;

  @override
  Widget build(BuildContext context) {
    return wrapInAlignment(
      renderSliver
          ? SliverPadding(
              padding: margin,
              sliver: SliverList.builder(
                itemCount: children.length,
                itemBuilder: (context, index) {
                  final child = children[index];
                  return child(context, index);
                },
              ),
            )
          : Padding(
              padding: margin,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: padding,
                shrinkWrap: true,
                itemCount: children.length,
                itemBuilder: (context, index) {
                  return children[index](context, index);
                },
              ),
            ),
    );
  }
}
