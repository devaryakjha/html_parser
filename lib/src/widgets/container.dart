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

  /// Returns sliver version of the container type.
  ContainerType toSliver() => switch (this) {
        ContainerType.column => ContainerType.sliverColumn,
        ContainerType.row => ContainerType.sliverRow,
        ContainerType.sliverColumn || ContainerType.sliverRow => this,
      };
}

/// A widget that is used to represent `div` or `container` elements.
///
/// This widget is used to render a container with children.
///
/// The children are rendered in a column or row based on the [type].
final class ContainerHtmlWidget extends StatelessWidget with IHtmlWidget {
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
    return SliverToBoxAdapter(
      child: _buildColumn(context, children),
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
    final builtChildren = children.map((builder) => builder(context)).toList();
    return switch (type) {
      ContainerType.column => _buildColumn(context, builtChildren),
      ContainerType.sliverColumn => _buildSliverColumn(context, builtChildren),
      ContainerType.row => _buildRow(context, builtChildren),
      ContainerType.sliverRow => _buildSliverRow(context, builtChildren),
    };
  }

  @override
  Styles get styles => style ?? const Styles.empty();
}
