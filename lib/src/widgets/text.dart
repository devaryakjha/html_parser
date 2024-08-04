import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render text.
///
/// represents `<text>`, `<p>`, `<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`, `<h6>`,
/// `<span>`, `<sup>`, `<sub>`, `<b>`, `<strong>`, `<i>`, `<em>`, `<br>`, `<a>`,
/// `<table>`, `<tr>`, `<td>`, `<th>`, `<tbody>`, `<thead>` tags.
///
final class TextHtmlWidget extends StatelessWidget with IHtmlWidget {
  /// Creates a new instance of [TextHtmlWidget].
  const TextHtmlWidget(
    this.textSpan, {
    super.key,
    Styles? styles,
    this.textStyle,
    this.maxLinesAllowed,
  }) : styles = styles ?? const Styles.empty();

  /// Inlinespan to use for the text.
  final InlineSpan textSpan;

  /// The [TextSpan] to use for the text.
  final int? maxLinesAllowed;

  /// The maximum number of lines to display.
  int? get maxLines => maxLinesAllowed ?? styles.maxLines;

  /// The [TextStyle] to use for the text.
  final TextStyle? textStyle;

  /// The [Styles] to use for the widget.
  @override
  final Styles styles;

  /// Effective [TextStyle] to use for the text.
  TextStyle? get style => textStyle ?? styles.textStyle;

  @override
  Widget build(BuildContext context) {
    if (textSpan.toPlainText().trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return wrapInAlignment(
      Builder(
        builder: (context) {
          final defaultAlignment = DefaultAlignment.of(context);
          return wrapInMargin(
            Text.rich(
              textSpan,
              textAlign: defaultAlignment.textAlign,
              style: style,
              maxLines: maxLines,
            ),
          );
        },
      ),
    );
  }
}
