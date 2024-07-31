// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

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

  /// Creates a new instance of [Styles].
  const Styles({
    this.margin,
    this.padding,
    this.textStyle,
  });

  @override
  List<Object?> get props => [margin, padding, textStyle];

  Styles copyWith({
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? textStyle,
  }) {
    return Styles(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
