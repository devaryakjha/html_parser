import 'package:flutter/widgets.dart';

/// An interface for creating instances of [Widget].
abstract interface class IHtmlWidget extends Widget {
  /// Creates a new instance of [IHtmlWidget].
  const IHtmlWidget({super.key, this.margin, this.padding});

  /// A placeholder widget.
  const factory IHtmlWidget.placeholder() = _Placeholder;

  final EdgeInsets? margin;

  final EdgeInsets? padding;
}

final class _Placeholder extends StatelessWidget implements IHtmlWidget {
  const _Placeholder() : super();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  EdgeInsets? get margin => null;

  @override
  EdgeInsets? get padding => null;
}
