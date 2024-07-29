import 'package:flutter/widgets.dart';

/// Abstract class for building HTML widgets.
@immutable
abstract class HtmlWidgetBuilder {
  /// Builds the HTML widget.
  Widget build(BuildContext context);
}
