import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// A widget that is used to render text.
///
/// represents `<text>`, `<p>`, `<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`, `<h6>`,
/// `<span>`, `<sup>`, `<sub>`, `<b>`, `<strong>`, `<i>`, `<em>`, `<br>`, `<a>`,
/// `<table>`, `<tr>`, `<td>`, `<th>`, `<tbody>`, `<thead>` tags.
///
final class TextHtmlWidget extends Text implements IHtmlWidget {
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
    this.styles,
    this.textStyle,
  }) : super.rich();

  /// The [TextSpan] to use for the text.
  final int? maxLinesAllowed;

  @override
  int? get maxLines => maxLinesAllowed ?? styles?.maxLines;

  /// The [TextStyle] to use for the text.
  final TextStyle? textStyle;

  /// The [Styles] to use for the widget.
  final Styles? styles;

  @override
  TextStyle? get style => textStyle ?? styles?.textStyle;

  @override
  EdgeInsets? get margin => styles?.margin;

  @override
  EdgeInsets? get padding => styles?.padding;

  Widget _wrapInMarginIfNeeded(Widget child) {
    if (margin == null) {
      return child;
    }

    return Padding(
      padding: margin!,
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
