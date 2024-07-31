import 'package:csslib/parser.dart' as css;
import 'package:csslib/visitor.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogStyles implements IHtmlStyles {
  const BlogStyles({
    this.styleSheets,
  });

  factory BlogStyles.fromCss(List<dynamic> inputs) {
    if (inputs.isEmpty) return const BlogStyles();
    final styleSheets = inputs.whereType<String>().map((input) {
      return css.parse(
        input,
        options: const css.PreprocessorOptions(
          useColors: false,
          checked: true,
          warningsAsErrors: true,
          inputFile: 'memory',
        ),
      );
    }).toList();
    return BlogStyles(styleSheets: styleSheets);
  }

  final List<StyleSheet>? styleSheets;

  static const String defaultFontFamily = 'Inter';

  @override
  Styles? getStyle(String? tag, dom.Node node) {
    return switch (tag) {
      'p' => const Styles(
          margin: EdgeInsets.only(top: 10, bottom: 20),
          textStyle: TextStyle(fontSize: 16),
        ),
      'a' => const Styles(
          textStyle: TextStyle(
            decoration: TextDecoration.underline,
            color: Color(0xff1669c9),
            decorationColor: Color(0xff1669c9),
          ),
        ),
      'em' || 'i' => const Styles(
          textStyle: TextStyle(fontStyle: FontStyle.italic),
        ),
      'b' || 'strong' => const Styles(
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      'h2' => const Styles(
          margin: EdgeInsets.only(top: 30),
          textStyle: TextStyle(fontSize: 27.2),
        ),
      'hr' => const Styles(),
      _ => const Styles(
          textStyle: TextStyle(fontSize: 16),
        ),
    };
  }

  @override
  List<Object?> get props => [styles];

  @override
  bool? get stringify => true;

  @override
  StylesMap get styles => const {};
}
