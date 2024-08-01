import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to represent `figure` elements.
final class FigureHtmlWidget extends StatelessWidget implements IHtmlWidget {
  /// Creates a new instance of [FigureHtmlWidget].
  const FigureHtmlWidget({
    super.key,
    this.style,
    this.children = const [],
  });

  /// The [Styles] to use for the widget.
  final Styles? style;

  /// The children to render.
  final List<WidgetBuilder> children;

  @override
  Widget build(BuildContext context) {
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
