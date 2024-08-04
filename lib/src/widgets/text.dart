import 'package:flutter/foundation.dart';
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
    required this.source,
    super.key,
    Styles? styles,
    this.textStyle,
    this.maxLinesAllowed,
  }) : styles = styles ?? const Styles.empty();

  /// The source of the text.
  final HtmlNode source;

  /// Inlinespan to use for the text.
  final InlineSpan textSpan;

  /// The [TextSpan] to use for the text.
  final int? maxLinesAllowed;

  /// The [TextStyle] to use for the text.
  final TextStyle? textStyle;

  /// The [Styles] to use for the widget.
  @override
  final Styles styles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<HtmlNode>('source', source))
      ..add(DiagnosticsProperty<Styles>('styles', styles))
      ..add(DiagnosticsProperty<TextStyle>('textStyle', textStyle))
      ..add(DiagnosticsProperty<int>('maxLinesAllowed', maxLinesAllowed))
      ..add(DiagnosticsProperty<InlineSpan>('textSpan', textSpan));
  }

  @override
  Widget build(BuildContext context) {
    final maxLines = maxLinesAllowed ?? styles.maxLines;
    final style = textStyle ?? styles.textStyle;
    final isOnlyNewLine = textSpan is TextSpan &&
        (textSpan.toPlainText() == '\n' ||
            textSpan.toPlainText().split('').every((val) => val == '\n'));

    if (isOnlyNewLine) {
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
