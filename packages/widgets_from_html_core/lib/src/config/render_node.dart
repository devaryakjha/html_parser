import 'package:flutter/widgets.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// Defines how the children of `Html` should be rendered.
///
/// See also:
///  * [HtmlConfig], which is used to configure the parser.
///  * [Html], which is used to render HTML.
///
enum RenderMode {
  /// Children are rendered in a [Column].
  column,

  /// Children are rendered in a [ListView].
  list,

  /// Children are rendered in a [Row].
  sliver;

  /// Whether this mode is [RenderMode.column].
  bool get isSliver => this == RenderMode.sliver;

  /// Whether this mode is [RenderMode.column].
  bool get isColumn => this == RenderMode.column;

  /// Whether this mode is [RenderMode.list].
  bool get isList => this == RenderMode.list;
}
