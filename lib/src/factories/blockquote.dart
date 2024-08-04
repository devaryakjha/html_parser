// ignore_for_file: avoid_unused_constructor_parameters

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render a [BlockquoteHtmlWidget].
/// Represents `<blockquote>` tag.
final class BlockquoteHtmlWidgetFactory
    implements IHtmlWidgetFactory<BlockquoteHtmlWidget> {
  /// Creates a new instance of [BlockquoteHtmlWidgetFactory].
  const BlockquoteHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [BlockquoteHtmlWidgetFactory] from a [HtmlNode].
  factory BlockquoteHtmlWidgetFactory.fromNode(
    HtmlNode node,
    UnsupportedParser unsupportedParser,
  ) {
    final children = node.nodes.map(unsupportedParser).whereNotNull().toList();

    return BlockquoteHtmlWidgetFactory(
      (context) {
        final config = HtmlConfig.of(context);
        return BlockquoteHtmlWidget(
          children: children.map((e) => e.builder).toList(),
          styles: config.styles.getStyle('blockquote', config.defaultTextStyle),
        );
      },
    );
  }

  final WidgetBuilder _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [_builder];

  @override
  WidgetBuilder get sliverBuilder => (context) {
        return SliverToBoxAdapter(child: builder(context));
      };

  @override
  bool? get stringify => true;
}
