import 'package:flutter/widgets.dart' show immutable;
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// The `HtmlExtension` class is the base class for all extensions.
///
/// Extensions are used to add custom functionality to the `Html` widget.
/// They can be used to add support for new tags, attributes, and more.
@immutable
abstract class HtmlExtension {
  /// The set of supported tags.
  Set<String> get supportedTags;

  /// Parses an element and returns a `ParsedResult`.
  List<ParsedResult> parseElement(Element element);
}
