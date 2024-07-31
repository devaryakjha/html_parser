import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

@immutable
final class HtmlConfig extends Equatable {
  /// A list of factories for creating instances of [IHtmlWidget].
  ///
  /// The key is the tag name of the element, and the value is the factory for
  /// creating instances of [IHtmlWidget].
  final Map<String, IHtmlWidgetFactory Function(dom.Node)> factories;

  /// A map of custom factories for creating instances of [IHtmlWidget].
  ///
  /// If a factory is provided for a tag name, it will be used instead of the
  /// default factory.
  final Map<String, IHtmlWidgetFactory Function(dom.Node)> customFactories;

  /// Creates a new instance of [HtmlConfig].
  HtmlConfig({
    this.customFactories = const {},
  }) : factories = {
          ...Map.fromEntries(TextHtmlWidgetFactory.tags.map((tag) {
            return MapEntry(tag, TextHtmlWidgetFactory.fromNode);
          })),
        };

  static HtmlConfig? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HtmlConfigProvider>()
        ?.config;
  }

  /// Gets the [HtmlConfig] from the given [context].
  static HtmlConfig of(BuildContext context) {
    final config = maybeOf(context);
    if (config == null) {
      throw Exception('No HtmlConfig found in the widget tree.');
    }
    return config;
  }

  @override
  List<Object?> get props => [factories, customFactories];

  @override
  bool? get stringify => true;
}

/// A provider for the [HtmlConfig].
final class HtmlConfigProvider extends InheritedWidget {
  /// The [HtmlConfig] to provide.
  final HtmlConfig config;

  /// Creates a new instance of [HtmlConfigProvider].
  const HtmlConfigProvider({
    required this.config,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(HtmlConfigProvider oldWidget) {
    return oldWidget.config != config;
  }
}
