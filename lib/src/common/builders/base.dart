import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;

/// Abstract class for building HTML widgets.
@immutable
abstract class HtmlWidgetBuilder {
  /// Creates a new instance of the [HtmlWidgetBuilder].
  const HtmlWidgetBuilder();

  /// Creates a new instance of the [HtmlWidgetBuilder] from the given node.
  const HtmlWidgetBuilder.fromNode(dom.Node node);

  /// Builds the HTML widget.
  Widget build(BuildContext context);
}
