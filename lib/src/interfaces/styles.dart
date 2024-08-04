// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

abstract interface class IHtmlStyles with EquatableMixin {
  final StylesMap styles;

  const IHtmlStyles(this.styles);

  const factory IHtmlStyles.emptyStyles() = _DefaultStyles;

  Styles? getStyle(String? tag, TextStyle defaultStyle);
}

final class _DefaultStyles implements IHtmlStyles {
  const _DefaultStyles();

  @override
  Styles? getStyle(String? tag, TextStyle defaultStyle) {
    return null;
  }

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;

  @override
  StylesMap get styles => const {};
}

/// A class that represents the styles of a widget.
final class Styles with EquatableMixin {
  /// The margin of the widget.
  final EdgeInsets? margin;

  /// The padding of the widget.
  final EdgeInsets? padding;

  /// The text style of the widget.
  final TextStyle? textStyle;

  /// The maximum number of lines to display.
  final int? maxLines;

  /// The alignment of the widget.
  final Alignment? alignment;

  TextAlign? get textAlign => alignment == null
      ? null
      : switch (alignment) {
          Alignment.topLeft ||
          Alignment.centerLeft ||
          Alignment.bottomLeft =>
            TextAlign.left,
          Alignment.centerRight ||
          Alignment.topRight ||
          Alignment.bottomRight =>
            TextAlign.right,
          _ => TextAlign.center,
        };

  /// Creates a new instance of [Styles].
  const Styles({
    this.margin,
    this.padding,
    this.textStyle,
    this.maxLines,
    this.alignment,
  });

  const Styles.empty()
      : margin = null,
        padding = null,
        textStyle = null,
        maxLines = null,
        alignment = null;

  @override
  List<Object?> get props => [margin, padding, textStyle, maxLines, alignment];

  Styles copyWith({
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? textStyle,
    int? maxLines,
    Alignment? alignment,
  }) {
    return Styles(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      maxLines: maxLines ?? this.maxLines,
      alignment: alignment ?? this.alignment,
    );
  }
}
