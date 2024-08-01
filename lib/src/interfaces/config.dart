import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

@immutable
class HtmlConfig extends Equatable {
  /// A list of factories for creating instances of [IHtmlWidget].
  ///
  /// The key is the tag name of the element, and the value is the factory for
  /// creating instances of [IHtmlWidget].
  final WidgetFactoryMap _factories;

  /// The styles to use for the widgets.
  ///
  /// If a tag is not found in the styles, no styles will be used.
  final IHtmlStyles styles;

  /// A callback that is called when a link is tapped.
  final OnLinkTap? onLinkTap;

  /// The default text style to use.
  ///
  /// This helps to ensure that all text has a consistent style.
  ///
  /// if not provided, a default text style with a font size of 16 and a line
  /// height of 1.4 will be used.
  final TextStyle defaultTextStyle;

  /// Creates a new instance of [HtmlConfig].
  HtmlConfig({
    WidgetFactoryMap customFactories = const {},
    this.styles = const IHtmlStyles.emptyStyles(),
    this.onLinkTap,
    this.defaultTextStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
  }) : _factories = _createDefaultFactories(customFactories);

  /// generates the default factories.
  ///
  /// and merges them with the custom factories.
  static WidgetFactoryMap _createDefaultFactories(WidgetFactoryMap? custom) {
    return {
      ...Map.fromEntries(TextHtmlWidgetFactory.tags.map((tag) {
        return MapEntry(tag, TextHtmlWidgetFactory.fromNode);
      })),
      'hr': HrHtmlWidgetFactory.fromNode,
      'figure': FigureHtmlWidgetFactory.fromNode,
      'img': ImageHtmlWidgetFactory.fromNode,
      'div': ContainerHtmlWidgetFactory.fromNode,
      'table': TableHtmlWidgetFactory.fromNode,
      'ol': ListHtmlWidgetFactory.fromNode,
      'ul': ListHtmlWidgetFactory.fromNode,
      'iframe': IframeHtmlWidgetFactory.fromNode,
      ...?custom,
    };
  }

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

  WidgetFactoryMapValue? getFactory(String? tag) {
    if (tag == null) return null;
    return _factories[tag];
  }

  @override
  List<Object?> get props => [_factories];

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
