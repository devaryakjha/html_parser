import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widgets_from_html_core/src/internals/render/html_renderer.dart';
import 'package:widgets_from_html_core/src/parser.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart'
    hide HTMLText;

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
/// - `config`: The configuration for parsing HTML.
/// - `padding`: The amount of space by which to inset the children.
///
/// {@endtemplate}
class Html extends StatefulWidget {
  /// Creates a [Html] widget.
  /// {@macro style}
  const Html({
    required this.data,
    this.config = const HtmlConfig(),
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  /// The HTML content to parse.
  final String data;

  /// Configuration for parsing HTML.
  final HtmlConfig config;

  /// The amount of space by which to inset the children.
  final EdgeInsets padding;

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  HtmlConfig get config => widget.config;

  String get data => widget.data;

  List<ParsedResult> _parsed = [];

  FutureOr<void> _parse() {
    _parsed = Parser(config: config).parse(data);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _parse();
    });
  }

  @override
  void didUpdateWidget(covariant Html oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != data || oldWidget.config != config) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _parse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_parsed.isEmpty) {
      return const SizedBox.shrink();
    }

    return HtmlList(
      key: ObjectKey(data),
      padding: widget.padding,
      config: config,
      children: _parsed.map((e) => e.call(context, config)).toList(),
    );
  }
}
