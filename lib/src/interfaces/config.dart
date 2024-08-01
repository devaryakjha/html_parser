import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// {@template html_config}
/// A configuration for the HTML widget.
///
/// `customFactories` is a map of [WidgetFactoryMapValue] to
/// use for creating widgets.
///
/// `styles` is the styles to use for the widgets.
///
/// `onLinkTap` is a callback that is called when a link is tapped.
///
/// `defaultTextStyle` is the default text style to use.
///
/// The `customFactories` map is a map of tag names to factories.
/// The key is the tag name of the element, and the value is the factory for
/// creating instances of [IHtmlWidget].
///
/// e.g.
/// ```dart
/// final config = HtmlConfig(
///  customFactories: {
///     'custom': (node, _) => CustomHtmlWidgetFactory.fromNode(node),
///   },
///   styles: MyHtmlStyles(),
///   onLinkTap: (href) {
///       if (href != null) {
///         final uri = Uri.tryParse(href);
///         if (uri != null) {
///           url_launcher.canLaunchUrl(uri).then((canLaunch) {
///           if (canLaunch) {
///             url_launcher.launchUrl(uri);
///           } else {
///             log('Could not launch $href');
///           }
///         });
///       }
///     }
///     log('Tapped on anchor: $href');
///   }
/// );
/// ```
///
/// {@endtemplate}
class HtmlConfig extends Equatable {
  /// Creates a new instance of [HtmlConfig].
  ///
  /// {@macro html_config}
  HtmlConfig({
    WidgetFactoryMap customFactories = const {},
    this.styles = const IHtmlStyles.emptyStyles(),
    this.onLinkTap,
    this.defaultTextStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
  }) : _factories = _createDefaultFactories(customFactories);

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

  /// generates the default factories.
  ///
  /// and merges them with the custom factories.
  static WidgetFactoryMap _createDefaultFactories(WidgetFactoryMap? custom) {
    return {
      ...Map.fromEntries(
        TextHtmlWidgetFactory.tags.map((tag) {
          return MapEntry(tag, TextHtmlWidgetFactory.fromNode);
        }),
      ),
      'hr': (_, __) => HrHtmlWidgetFactory.fromNode(),
      'figure': FigureHtmlWidgetFactory.fromNode,
      'img': (node, _) => ImageHtmlWidgetFactory.fromNode(node),
      'div': ContainerHtmlWidgetFactory.fromNode,
      'table': TableHtmlWidgetFactory.fromNode,
      'ol': (node, _) => ListHtmlWidgetFactory.fromNode(node),
      'ul': (node, _) => ListHtmlWidgetFactory.fromNode(node),
      'iframe': (node, _) => IframeHtmlWidgetFactory.fromNode(node),
      ...?custom,
    };
  }

  /// Gets the [HtmlConfig] from the given [context].
  static HtmlConfig? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HtmlConfigProvider>()
        ?.config;
  }

  /// Gets the [HtmlConfig] from the given [context].
  ///
  /// Throws an exception if no [HtmlConfig] is found.
  static HtmlConfig of(BuildContext context) {
    final config = maybeOf(context);
    if (config == null) {
      throw Exception('No HtmlConfig found in the widget tree.');
    }
    return config;
  }

  /// Gets the factory for the given [tag].
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
  /// Creates a new instance of [HtmlConfigProvider].
  const HtmlConfigProvider({
    required this.config,
    required super.child,
    super.key,
  });

  /// The [HtmlConfig] to provide.
  final HtmlConfig config;

  @override
  bool updateShouldNotify(HtmlConfigProvider oldWidget) {
    return oldWidget.config != config;
  }
}
