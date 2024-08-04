import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/src/widgets/alignment_provider.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// An interface for creating instances of [Widget].
mixin IHtmlWidget on Widget {
  /// Placeholder widget.
  static const placeholder = _Placeholder();

  /// The styles to use for the widget.
  Styles get styles => const Styles.empty();

  /// The margin of the widget.
  EdgeInsets get margin => styles.margin ?? EdgeInsets.zero;

  /// The padding of the widget.
  EdgeInsets get padding => styles.padding ?? EdgeInsets.zero;

  /// The alignment of the widget.
  Alignment? get alignment => styles.alignment;

  /// Wraps the given [child] in a [Padding] widget.
  Widget wrapInAlignment(Widget child) {
    final alignment = this.alignment;
    return alignment == null
        ? child
        : DefaultAlignment(alignment: alignment, child: child);
  }

  /// Wraps the given [child] in a [Padding] widget.
  Widget wrapInMargin(Widget child) {
    if (margin == EdgeInsets.zero) {
      return child;
    }

    return Padding(
      padding: margin,
      child: child,
    );
  }
}

final class _Placeholder extends StatelessWidget with IHtmlWidget {
  const _Placeholder() : super();

  @override
  Widget build(BuildContext context) => wrapInAlignment(const Placeholder());
}
