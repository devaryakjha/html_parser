import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A widget that is used pass down the default alignment to its children.
final class DefaultAlignment extends InheritedTheme {
  /// Creates a new instance of [DefaultAlignment].
  const DefaultAlignment({
    required super.child,
    this.alignment,
    super.key,
  });

  /// The default alignment from the closest instance
  /// of this class that encloses the given context.
  factory DefaultAlignment.of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DefaultAlignment>() ??
        const DefaultAlignment.fallback();
  }

  /// Creates a new instance of [DefaultAlignment] with a fallback value.
  const DefaultAlignment.fallback({super.key})
      : alignment = null,
        super(child: const _NullWidget());

  /// The default alignment to use.
  final AlignmentGeometry? alignment;

  /// Converts the alignment to a [TextAlign].
  TextAlign get textAlign {
    if (alignment == null) {
      return TextAlign.start;
    }

    if (alignment is Alignment) {
      final a = alignment! as Alignment;
      if (a.x == -1) {
        return TextAlign.left;
      }
      if (a.x == 1) {
        return TextAlign.right;
      }
    }

    return TextAlign.center;
  }

  /// Converts the alignment to a [MainAxisAlignment].
  MainAxisAlignment get columnMainAxisAlignment {
    if (alignment == null) {
      return MainAxisAlignment.start;
    }

    if (alignment is Alignment) {
      final a = alignment! as Alignment;
      if (a.y == -1) {
        return MainAxisAlignment.start;
      }
      if (a.y == 1) {
        return MainAxisAlignment.end;
      }
    }

    return MainAxisAlignment.center;
  }

  @override
  bool updateShouldNotify(covariant DefaultAlignment oldWidget) {
    return oldWidget.alignment != alignment;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return DefaultAlignment(
      alignment: alignment,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DiagnosticsProperty('textAlign', textAlign));
  }
}

class _NullWidget extends StatelessWidget {
  const _NullWidget();

  @override
  Widget build(BuildContext context) {
    throw FlutterError(
      'A DefaultTextStyle constructed with DefaultTextStyle.fallback cannot be '
      'incorporated into the widget tree, '
      'it is meant only to provide a fallback value returned '
      'by DefaultTextStyle.of() '
      'when no enclosing default text style is present in a BuildContext.',
    );
  }
}
