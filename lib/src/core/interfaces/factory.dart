import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart' show IHtmlWidget;

/// An interface for creating instances of [IHtmlWidget].
abstract interface class IHtmlWidgetFactory<Widget extends IHtmlWidget> {
  /// Creates a new instance of [IHtmlWidgetFactory].
  const IHtmlWidgetFactory(this.widget);

  /// Creates a new instance of [IHtmlWidget] from the given [node].
  final Widget widget;

  /// Creates a new instance of [IHtmlWidgetFactory] from the given [node].
  const IHtmlWidgetFactory.fromNode(final dom.Node node)
      : widget = const IHtmlWidget.placeholder() as Widget;
}
