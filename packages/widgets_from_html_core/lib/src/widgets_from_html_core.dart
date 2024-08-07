import 'package:flutter/material.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// {@template style}
///
/// The entrypoint for this package.
///
/// The `Html` widgets takes HTML string as input
/// and converts it to an Flutter widgets.
///
/// **Attributes**:
///
/// - `data`: The HTML content to parse.
///
/// - `config`: The configuration for parsing HTML.
///
/// {@endtemplate}
class Html extends StatefulWidget {
  /// Creates a [Html] widget.
  /// {@macro style}
  const Html({
    required this.data,
    this.config = const HtmlConfig(),
    super.key,
  });

  /// The HTML content to parse.
  final String data;

  /// {@macro config}
  final HtmlConfig config;

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
