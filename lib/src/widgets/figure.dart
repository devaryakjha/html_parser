import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

final class FigureHtmlWidget extends StatelessWidget implements IHtmlWidget {
  const FigureHtmlWidget({
    super.key,
    this.style,
    this.children = const [],
  });

  /// The [Styles] to use for the widget.
  final Styles? style;
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
