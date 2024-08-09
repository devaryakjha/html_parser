/// Core implementation for `Html`.
///
/// This package exposes `Html` entrypoint to parse HTML content and convert it
/// to Flutter widgets.
///
/// It is a set of bare minimum classes and interfaces to parse HTML content
/// that supports rudimentary HTML tags and attributes.
///
/// It is designed to be extended by other packages to provide more features.
///
/// ## Usage
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:widgets_from_html_core/widgets_from_html_core.dart';
///
/// void main() {
///  runApp(
///   const MaterialApp(
///       home: Scaffold(
///         body: Html(data: '<h1>Hello World</h1>'),
///       ),
///     ),
///   );
/// }
/// ```
library widgets_from_html_core;

export 'src/config/config.dart';
export 'src/extension.dart';
export 'src/html/html.dart';
export 'src/parsed_result.dart';
export 'src/style.dart';
export 'src/typedefs.dart';
export 'src/widgets_from_html_core.dart';
