import 'package:flutter/widgets.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// {@template parsed_result}
/// `ParsedResult` represents the result of parsing HTML.
///
/// **Attributes**:
///
/// - `style`: Style to be applied to the resulting widget.
/// {@endtemplate}
// Helps standardize the output of parsing HTML.
@immutable
final class ParsedResult {
  /// Creates a [ParsedResult].
  ///
  /// {@macro parsed_result}
  const ParsedResult({
    required this.style,
  });

  /// Style to be applied to the resulting widget.
  final Style style;
}
