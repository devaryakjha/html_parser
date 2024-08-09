import 'package:flutter/widgets.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// {@template parsed_result}
/// `ParsedResult` represents the result of parsing HTML.
///
/// **Attributes**:
///
/// - `style`: Style to be applied to the resulting widget.
/// - `builder`: builder function for the resulting widget.
///
/// {@endtemplate}
// Helps standardize the output of parsing HTML.
@immutable
final class ParsedResult {
  /// Creates a [ParsedResult].
  ///
  /// {@macro parsed_result}
  const ParsedResult({
    required WidgetBuilder builder,
    required this.source,
    this.children = const [],
    this.style = const Style(),
  }) : _builder = builder;

  /// Creates a [ParsedResult] from a [node].
  static ParsedResult? fromNode(Node node, HtmlConfig config) {
    final extension = config.getEffectiveExtensionForNode(node);
    if (extension == null) return null;
    return extension.parseNode(node, config);
  }

  /// Style to be applied to the resulting widget.
  final Style style;

  /// builder function for the resulting widget.
  final WidgetBuilder _builder;

  /// An array of children.
  ///
  /// for example, a [ParsedResult] for a `table`
  /// tag will have children for `thead`, `tbody`, and `tfoot`.
  final List<ParsedResult> children;

  /// The source from which the [_builder] was created.
  final Node source;

  /// Redirects to [_builder].
  Widget call(BuildContext context, HtmlConfig config) => _builder(context);
}
