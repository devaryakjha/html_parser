import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:widgets_from_html_core/src/config/render_node.dart';
import 'package:widgets_from_html_core/src/internals/internals.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// {@template config}
///
/// This class represents all configurations for parsing HTML.
///
/// **Attributes**:
///
/// - `onTap`: The callback for tap event.
/// - `extensions`: List of [HtmlExtension] to be applied.
/// - `styleOverrides`: A map of style to be applied to the resulting widget.
/// - `renderMode`: Defines how the children of [Html] should be rendered.
/// - `gap`: The gap between the children of [Html].
///
/// {@endtemplate}
@immutable
final class HtmlConfig {
  /// Creates a [HtmlConfig].
  ///
  /// {@macro config}
  const HtmlConfig({
    this.onTap,
    this.extensions = const [],
    this.styleOverrides = const {},
    this.renderMode = RenderMode.column,
    this.gap = 0.0,
  });

  /// This callback is invoked when a link is tapped.
  final OnLinkTap? onTap;

  /// List of extensions to be applied.
  final List<HtmlExtension> extensions;

  /// A map of style to be applied to the resulting widget.
  /// The `key` is the tag name and the `value` is an instance of [Style] class.
  /// This will override the default style extracted from the html.
  final Map<String, Style> styleOverrides;

  /// Defines how the children of [Html] should be rendered.
  ///
  /// default is [RenderMode.column]
  final RenderMode renderMode;

  /// The gap between the children of [Html].
  ///
  /// - In case of [RenderMode.column],
  ///   this will be the space between the children.
  /// - In case of [RenderMode.list] and [RenderMode.sliver]
  ///   this will be the space between the list items.
  final double gap;

  static const List<HtmlExtension> _builtInExtensions = [
    TextExtension(),
    FigureExtension(),
    ImageExtension(),
  ];

  /// Returns [HtmlExtension] for the given [node] if supported.
  @internal
  HtmlExtension? getEffectiveExtensionForNode(Node node) {
    for (final extension in extensions) {
      if (extension.isNodeSupported(node)) {
        return extension;
      }
    }
    for (final extension in _builtInExtensions) {
      if (extension.isNodeSupported(node)) {
        return extension;
      }
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HtmlConfig &&
          runtimeType == other.runtimeType &&
          onTap == other.onTap &&
          renderMode == other.renderMode &&
          listEquals(extensions, other.extensions) &&
          mapEquals(styleOverrides, other.styleOverrides);

  @override
  int get hashCode =>
      Object.hashAll([onTap, extensions, styleOverrides, renderMode]);

  @override
  String toString() {
    return 'HtmlConfig('
        ' onTap: $onTap, extensions: $extensions,'
        ' styleOverrides: $styleOverrides, renderMode: $renderMode'
        ' gap: $gap'
        ' )';
  }
}
