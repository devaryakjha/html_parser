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

  late List<IHtmlWidgetFactory> _widgetsFactories;

  late _HtmlRenderer _renderer;

  void _reinitialise() {
    _widgetsFactories = parser.parse(input);
    final renderMode = config.renderMode;
    _renderer = switch (renderMode) {
      HtmlRenderMode.column => _RenderHtmlColumn(
          itemCount: _widgetsFactories.length,
          height: config.height,
          itemBuilder: (context, index) {
            final factory = _widgetsFactories[index];
            return factory.builder(context);
          },
        ),
      HtmlRenderMode.list => _RenderListView(
          itemCount: _widgetsFactories.length,
          height: config.height,
          itemBuilder: (context, index) {
            final factory = _widgetsFactories[index];
            return factory.builder(context);
          },
        ),
      HtmlRenderMode.sliver => _RenderSliver(
          itemCount: _widgetsFactories.length,
          height: config.height,
          itemBuilder: (context, index) {
            final factory = _widgetsFactories[index];
            return factory.sliverBuilder(context);
          },
        ),
    };
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _reinitialise();
  }

  @override
  void didUpdateWidget(covariant Html oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.input != widget.input || oldWidget.config != widget.config) {
      _reinitialise();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: config.defaultTextStyle,
      child: HtmlConfigProvider(
        config: config,
        child: Builder(
          builder: _renderer.buildWidget,
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

  Widget buildWidget(BuildContext context) => build(context);
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
