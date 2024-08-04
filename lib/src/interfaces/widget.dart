import 'package:flutter/widgets.dart';
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
}

final class _Placeholder extends StatelessWidget with IHtmlWidget {
  const _Placeholder() : super();

  @override
  Widget build(BuildContext context) => const Placeholder();
}
