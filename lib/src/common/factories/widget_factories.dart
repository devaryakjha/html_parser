part of 'factories.dart';

abstract class WidgetFactories {
  /// Create a new widget factory.
  const WidgetFactories(this.factories);

  /// The default factories that can create widgets.
  static const defaultFactories = [TextFactory()];

  /// The default factories that can create widgets.
  static const defaulWidgetFactories = DefaultWidgetFactories();

  /// The factories that can create widgets.
  final List<WidgetFactory> factories;

  /// Create a widget from the given HTML content.
  HtmlItem create(dom.Node node) {
    if (node is! dom.Element && node is! dom.Text) {
      throw UnimplementedError('No factory for ${node.runtimeType}');
    }

    final WidgetFactory factory = factories.firstWhereOrNull(
          (factory) => node is dom.Element
              ? factory.tags.contains(node.localName)
              : factory.tags.contains('p'),
        ) ??
        UnsupportedWidgetFactory(
          node is dom.Element ? node.localName ?? '' : 'p',
        );

    return factory.create(node);
  }
}

class DefaultWidgetFactories extends WidgetFactories {
  const DefaultWidgetFactories() : super(WidgetFactories.defaultFactories);
}
