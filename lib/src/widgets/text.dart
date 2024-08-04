import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render text.
///
/// represents `<text>`, `<p>`, `<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`, `<h6>`,
/// `<span>`, `<sup>`, `<sub>`, `<b>`, `<strong>`, `<i>`, `<em>`, `<br>`, `<a>`,
/// `<table>`, `<tr>`, `<td>`, `<th>`, `<tbody>`, `<thead>` tags.
///
final class TextHtmlWidget extends Text with IHtmlWidget {
  /// Creates a new instance of [TextHtmlWidget].
  const TextHtmlWidget(
    super.textSpan, {
    super.key,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    this.maxLinesAllowed,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    Styles? styles,
    this.textStyle,
  })  : styles = styles ?? const Styles.empty(),
        super.rich();

  /// The [TextSpan] to use for the text.
  final int? maxLinesAllowed;

  @override
  int? get maxLines => maxLinesAllowed ?? styles.maxLines;

  /// The [TextStyle] to use for the text.
  final TextStyle? textStyle;

  /// The [Styles] to use for the widget.
  @override
  final Styles styles;

  @override
  TextStyle? get style => textStyle ?? styles.textStyle;

  Widget _wrapInMarginIfNeeded(Widget child) {
    if (margin == EdgeInsets.zero) {
      return child;
    }

    return Padding(
      padding: margin,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (textSpan!.toPlainText().trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return _wrapInMarginIfNeeded(super.build(context));
  }
}
