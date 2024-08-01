import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

enum ContainerType {
  column,
  row;

  bool get isColumn => this == ContainerType.column;
  bool get isRow => this == ContainerType.row;
}

final class ContainerHtmlWidget extends StatelessWidget implements IHtmlWidget {
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

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      ContainerType.column => _buildColumn(
          context, children.map((builder) => builder(context)).toList()),
      ContainerType.row => _buildRow(
          context, children.map((builder) => builder(context)).toList()),
    };
  }

  @override
  EdgeInsets get margin => style?.margin ?? EdgeInsets.zero;

  @override
  EdgeInsets get padding => style?.padding ?? EdgeInsets.zero;
}
