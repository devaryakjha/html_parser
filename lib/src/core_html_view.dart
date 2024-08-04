import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget for displaying HTML content.
class Html extends StatefulWidget {
  /// Creates an HTML widget.
  Html(
    this.input, {
    super.key,
    HtmlConfig? config,
    HtmlParser? parser,
  })  : config = config ?? HtmlConfig(),
        parser = parser ?? HtmlParser(config ?? HtmlConfig());

  /// The configuration for the HTML widget.
  final HtmlConfig config;

  /// The parser to use for parsing the HTML string.
  final IHtmlParser parser;

  /// The HTML string to display.
  final String input;

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  String get input => widget.input;
  IHtmlParser get parser => widget.parser;

  HtmlConfig get config => widget.config;

  late final List<IHtmlWidgetFactory> _widgetsFactories;

  void _initialise() {
    _widgetsFactories = parser.parse(input);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initialise();
  }

  @override
  Widget build(BuildContext context) {
    final factories = kDebugMode ? parser.parse(input) : _widgetsFactories;
    final renderMode = config.renderMode;
    return DefaultTextStyle(
      style: config.defaultTextStyle,
      child: HtmlConfigProvider(
        config: config,
        child: Builder(
          builder: (context) {
            return switch (renderMode) {
              HtmlRenderMode.column => _RenderHtmlColumn(
                  itemCount: factories.length,
                  height: config.height,
                  itemBuilder: (context, index) {
                    final factory = factories[index];
                    return factory.builder(context);
                  },
                ),
              HtmlRenderMode.list => _RenderListView(
                  itemCount: factories.length,
                  height: config.height,
                  itemBuilder: (context, index) {
                    final factory = factories[index];
                    return factory.builder(context);
                  },
                ),
              HtmlRenderMode.sliver => _RenderSliver(
                  itemCount: factories.length,
                  height: config.height,
                  itemBuilder: (context, index) {
                    final factory = factories[index];
                    return factory.sliverBuilder(context);
                  },
                ),
            }
                // ignore: invalid_use_of_protected_member
                .build(context);
          },
        ),
      ),
    );
  }
}

abstract class _HtmlRenderer extends StatelessWidget {
  const _HtmlRenderer({
    required this.itemBuilder,
    required this.itemCount,
    this.height,
  });

  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  final double? height;
}

class _RenderHtmlColumn extends _HtmlRenderer {
  const _RenderHtmlColumn({
    required super.itemBuilder,
    required super.itemCount,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => itemBuilder(context, index),
      ),
    );
  }
}

class _RenderListView extends _HtmlRenderer {
  const _RenderListView({
    required super.itemBuilder,
    required super.itemCount,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

class _RenderSliver extends _HtmlRenderer {
  const _RenderSliver({
    required super.itemBuilder,
    required super.itemCount,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ...List.generate(
          itemCount,
          (index) => itemBuilder(context, index),
        ),
      ],
    );
  }
}
