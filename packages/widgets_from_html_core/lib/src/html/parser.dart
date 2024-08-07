import 'package:html/parser.dart' as parser;
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// Parse HTML string to [Document].
///
/// Alias for `package:html/parser.dart` [parser.parse].
///
/// ```dart
/// import 'package:widgets_from_html_core/widgets_from_html_core.dart';
///
/// void main() {
///  final doc = parseHtml('<div>Hello <strong>world</strong>!</div>');
///  print(doc.outerHtml);
/// }
/// ```
///
Document parseHtml(String html) {
  return parser.parse(html);
}
