import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render a [BlockquoteHtmlWidget].
final class BlockquoteHtmlWidget extends StatelessWidget with IHtmlWidget {
  /// Creates a new instance of [BlockquoteHtmlWidget].
  const BlockquoteHtmlWidget({
    super.key,
    this.children = const [],
    Styles? styles,
  })  : _styles = styles,
        renderSliver = false;

  /// Creates a new instance of [BlockquoteHtmlWidget] as a sliver.
  const BlockquoteHtmlWidget.sliver({
    super.key,
    this.children = const [],
    Styles? styles,
  })  : _styles = styles,
        renderSliver = true;

  /// The children to render.
  final List<WidgetBuilder> children;

  /// The styles to use for the widget.
  final Styles? _styles;

  @override
  Styles get styles => _styles ?? super.styles;

  /// Shows if the widget should be rendered as a sliver.
  final bool renderSliver;

  @override
  Widget build(BuildContext context) {
    if (renderSliver) {
      return SliverPadding(
        padding: margin,
        sliver: SliverList.builder(
          itemBuilder: (context, index) {
            return children[index](context);
          },
          itemCount: children.length,
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
  EdgeInsets get margin => styles.margin ?? EdgeInsets.zero;

  @override
  EdgeInsets get padding => styles.padding ?? EdgeInsets.zero;
}
