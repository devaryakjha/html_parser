import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

final class FigureHtmlWidget extends StatelessWidget implements IHtmlWidget {
  const FigureHtmlWidget({
    super.key,
    this.style,
  });

  /// The [Styles] to use for the widget.
  final Styles? style;

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Figure',
    );
  }

  @override
  EdgeInsets? get margin => style?.margin;

  @override
  EdgeInsets? get padding => style?.padding;
}
