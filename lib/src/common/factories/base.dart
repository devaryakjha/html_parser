part of 'factories.dart';

/// Abstract class for creating widgets.
@immutable
abstract class WidgetFactory {
  /// Create a new widget factory.
  const WidgetFactory(this.tags);

  /// The tag that this factory can create widgets for.
  final List<String> tags;

  /// Create a widget from the given HTML content.
  HtmlItem create(dom.Node node);
}
