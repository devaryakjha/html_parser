import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

final class BlogStyles implements IHtmlStyles {
  const BlogStyles();

  static const String defaultFontFamily = 'Inter';
  static String getFontFamily(String tag) {
    return switch (tag) {
      'h1' || 'h2' || 'h3' || 'h4' || 'h5' || 'h6' => 'Source Serif 4',
      _ => defaultFontFamily,
    };
  }

  TextStyle _getDefaultTextStyle(String fontFamily) {
    try {
      return GoogleFonts.getFont(fontFamily);
    } catch (e) {
      return GoogleFonts.getFont(defaultFontFamily);
    }
  }

  @override
  Styles? getStyle(String? tag, dom.Node node) {
    final defaultTextStyle = _getDefaultTextStyle(getFontFamily(tag!));
    return switch (tag) {
      'p' => Styles(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          textStyle: defaultTextStyle.copyWith(fontSize: 16),
        ),
      'a' => Styles(
          textStyle: defaultTextStyle.copyWith(
            decoration: TextDecoration.underline,
            color: const Color(0xff1669c9),
            decorationColor: const Color(0xff1669c9),
          ),
        ),
      'em' || 'i' => Styles(
          textStyle: defaultTextStyle.copyWith(fontStyle: FontStyle.italic),
        ),
      'b' || 'strong' => Styles(
          textStyle: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      'h2' => Styles(
          margin: const EdgeInsets.only(top: 30),
          textStyle: defaultTextStyle.copyWith(fontSize: 27.2),
        ),
      'hr' => const Styles(),
      _ => Styles(
          textStyle: defaultTextStyle.copyWith(fontSize: 16),
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
