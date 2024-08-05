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
    this.appendItems = const [],
    this.prependItems = const [],
  })  : config = config ?? HtmlConfig(),
        parser = parser ?? HtmlParser(config ?? HtmlConfig());

  /// The configuration for the HTML widget.
  final HtmlConfig config;

  /// The parser to use for parsing the HTML string.
  final IHtmlParser parser;

  /// The HTML string to display.
  final String input;

  /// Widgets to prepend to the HTML content.
  final List<Widget> prependItems;

  /// Widgets to append to the HTML content.
  final List<Widget> appendItems;

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
          prependItems: widget.prependItems,
          appendItems: widget.appendItems,
          itemBuilder: (context, index) {
            final factory = _widgetsFactories[index];
            return factory.builder(context);
          },
        ),
      HtmlRenderMode.list => _RenderListView(
          itemCount: _widgetsFactories.length,
          height: config.height,
          prependItems: widget.prependItems,
          appendItems: widget.appendItems,
          itemBuilder: (context, index) {
            final factory = _widgetsFactories[index];
            return factory.builder(context);
          },
        ),
      HtmlRenderMode.sliver => _RenderSliver(
          itemCount: _widgetsFactories.length,
          height: config.height,
          prependItems: widget.prependItems,
          appendItems: widget.appendItems,
          itemBuilder: (context, index) {
            final factory = _widgetsFactories[index];
            return factory.sliverBuilder(context);
          },
        ),
      HtmlRenderMode.sliverList => _RenderSliverList(
          itemCount: _widgetsFactories.length,
          height: config.height,
          prependItems: widget.prependItems,
          appendItems: widget.appendItems,
          itemBuilder: (context, index) {
            final factory = _widgetsFactories[index];
            return factory.builder(context);
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

  Widget _wrapInDefaultTextStyle(HtmlConfig config, Widget child) {
    if (config.animateTextStyleChange) {
      return AnimatedDefaultTextStyle(
        duration: config.animationDuration,
        style: config.defaultTextStyle,
        child: child,
      );
    }
    return DefaultTextStyle(
      style: config.defaultTextStyle,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _wrapInDefaultTextStyle(
      config,
      HtmlConfigProvider(
        config: config,
        child: _renderer.buildWidget(context),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('input', input))
      ..add(DiagnosticsProperty('config', config));
  }
}

abstract class _HtmlRenderer extends StatelessWidget {
  const _HtmlRenderer({
    required this.itemBuilder,
    required this.itemCount,
    this.prependItems = const [],
    this.appendItems = const [],
    this.height,
  });

  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  final double? height;

  final List<Widget> prependItems;

  final List<Widget> appendItems;

  Widget buildWidget(BuildContext context) {
    if (height != null) {
      return SizedBox(
        height: height,
        child: Builder(builder: build),
      );
    }

    return Builder(builder: build);
  }
}

class _RenderHtmlColumn extends _HtmlRenderer {
  const _RenderHtmlColumn({
    required super.itemBuilder,
    required super.itemCount,
    super.prependItems,
    super.appendItems,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...prependItems,
        ...List.generate(
          itemCount,
          (index) => itemBuilder(context, index),
        ),
        ...appendItems,
      ],
    );
  }
}

class _RenderListView extends _HtmlRenderer {
  const _RenderListView({
    required super.itemBuilder,
    required super.itemCount,
    super.prependItems,
    super.appendItems,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount + prependItems.length + appendItems.length,
      itemBuilder: (context, index) {
        if (index < prependItems.length) {
          return prependItems[index];
        }
        if (index < itemCount + prependItems.length) {
          return itemBuilder(context, index - prependItems.length);
        }
        return appendItems[index - itemCount - prependItems.length];
      },
    );
  }
}

class _RenderSliver extends _HtmlRenderer {
  const _RenderSliver({
    required super.itemBuilder,
    required super.itemCount,
    super.prependItems,
    super.appendItems,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ...prependItems,
        ...List.generate(
          itemCount,
          (index) => itemBuilder(context, index),
        ),
        ...appendItems,
      ],
    );
  }
}

class _RenderSliverList extends _HtmlRenderer {
  const _RenderSliverList({
    required super.itemBuilder,
    required super.itemCount,
    super.prependItems,
    super.appendItems,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < prependItems.length) {
            return prependItems[index];
          }
          if (index < itemCount + prependItems.length) {
            return itemBuilder(context, index - prependItems.length);
          }
          return appendItems[index - itemCount - prependItems.length];
        },
        childCount: itemCount + prependItems.length + appendItems.length,
      ),
    );
  }
}
