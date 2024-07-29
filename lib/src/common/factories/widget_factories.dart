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
    if (node is! dom.Element || node is! dom.Text) {
      throw UnimplementedError('No factory for ${node.runtimeType}');
    }

    final factory = factories.firstWhere(
      (factory) => factory.tags.contains(node.localName),
      orElse: () =>
          throw UnimplementedError('No factory for ${node.localName}'),
    );

    return factory.create(node);
  }
}

class DefaultWidgetFactories extends WidgetFactories {
  const DefaultWidgetFactories() : super(WidgetFactories.defaultFactories);
}
