import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to represent `figure` elements.
final class FigureHtmlWidget extends StatelessWidget implements IHtmlWidget {
  /// Creates a new instance of [FigureHtmlWidget].
  const FigureHtmlWidget({
    super.key,
    this.style,
    this.children = const [],
  }) : renderSliver = false;

  /// Creates a new instance of [FigureHtmlWidget] for sliver.
  const FigureHtmlWidget.sliver({
    super.key,
    this.style,
    this.children = const [],
  }) : renderSliver = true;

  /// The [Styles] to use for the widget.
  final Styles? style;

  /// The children to render.
  final List<WidgetBuilder> children;

  /// Whether to render as sliver.
  ///
  /// If `true`, the widget will be wrapped in [SliverPadding] and [SliverList].
  final bool renderSliver;

  @override
  Widget build(BuildContext context) {
    if (renderSliver) {
      return SliverPadding(
        padding: margin,
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) => children[i](context),
            childCount: children.length,
          ),
        ),
      );
    }
    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((e) => e(context)).toList(),
      ),
    );
  }

  @override
  EdgeInsets get margin => style?.margin ?? EdgeInsets.zero;

  @override
  EdgeInsets? get padding => style?.padding;
}
