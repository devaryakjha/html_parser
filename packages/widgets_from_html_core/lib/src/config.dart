import 'package:flutter/widgets.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// {@template config}
///
/// This class represents all configurations for parsing HTML.
///
/// **Attributes**:
///
/// - `onTap`: The callback for tap event.
///
/// - `extensions`: List of [HtmlExtension] to be applied.
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
  });

  /// This callback is invoked when a link is tapped.
  final OnLinkTap? onTap;

  /// List of extensions to be applied.
  final List<HtmlExtension> extensions;
}
