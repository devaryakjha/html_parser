import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// The type of container to render.
enum ContainerType {
  /// A column container.
  column,

  /// A sliver column container.
  sliverColumn,

  /// A row container.
  row,

  /// A sliver row container.
  sliverRow;

  /// Returns `true` if this is a column container.
  bool get isColumn => this == ContainerType.column;

  /// Returns `true` if this is a row container.
  bool get isRow => this == ContainerType.row;
}

/// A widget that is used to represent `div` or `container` elements.
///
/// This widget is used to render a container with children.
///
/// The children are rendered in a column or row based on the [type].
final class ContainerHtmlWidget extends StatelessWidget implements IHtmlWidget {
  /// Creates a new instance of [ContainerHtmlWidget].
  const ContainerHtmlWidget({
    super.key,
    this.style,
    this.type = ContainerType.column,
    this.children = const [],
  });

  /// The [Styles] to use for the widget.
  final Styles? style;

  /// The type of container to render.
  final ContainerType type;

  /// The children to render.
  final List<WidgetBuilder> children;

  Widget _buildColumn(BuildContext context, List<Widget> children) {
    return Padding(
      padding: margin,
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSliverColumn(BuildContext context, List<Widget> children) {
    return SliverPadding(
      padding: margin,
      sliver: SliverList(
        delegate: SliverChildListDelegate(children),
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<Widget> children) {
    return Padding(
      padding: EdgeInsets.only(top: margin.top, bottom: margin.bottom),
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(left: margin.left)),
          ...children,
          Padding(padding: EdgeInsets.only(right: margin.right)),
        ],
      ),
    );
  }

  Widget _buildSliverRow(BuildContext context, List<Widget> children) {
    return SliverToBoxAdapter(
      child: _buildRow(context, children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      ContainerType.column => _buildColumn(
          context,
          children.map((builder) => builder(context)).toList(),
        ),
      ContainerType.sliverColumn => _buildSliverColumn(
          context,
          children.map((builder) => builder(context)).toList(),
        ),
      ContainerType.row => _buildRow(
          context,
          children.map((builder) => builder(context)).toList(),
        ),
      ContainerType.sliverRow => _buildSliverRow(
          context,
          children.map((builder) => builder(context)).toList(),
        ),
    };
  }

  @override
  EdgeInsets get margin => style?.margin ?? EdgeInsets.zero;

  @override
  EdgeInsets get padding => style?.padding ?? EdgeInsets.zero;
}
