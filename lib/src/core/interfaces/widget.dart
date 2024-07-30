import 'package:flutter/widgets.dart';

/// An interface for creating instances of [Widget].
abstract interface class IHtmlWidget extends Widget {
  /// Creates a new instance of [IHtmlWidget].
  const IHtmlWidget({super.key});

  /// A placeholder widget.
  const factory IHtmlWidget.placeholder() = _Placeholder;
}

final class _Placeholder extends StatelessWidget implements IHtmlWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
