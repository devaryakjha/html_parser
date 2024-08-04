import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render a horizontal rule.
typedef HrHtmlWidget = Divider Function(BuildContext);

/// A factory for creating a horizontal rule widget.
///
/// represents `<hr>` tag.
final class HrHtmlWidgetFactory implements IHtmlWidgetFactory {
  /// Creates a new instance of [HrHtmlWidgetFactory].
  const HrHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [HrHtmlWidgetFactory] from a [HtmlNode].
  factory HrHtmlWidgetFactory.fromNode() {
    return HrHtmlWidgetFactory(
      (context) {
        final color = HtmlConfig.of(context).defaultTextStyle.color;
        return Divider(
          thickness: 2,
          height: 1,
          color: color,
        );
      },
    );
  }

  final HrHtmlWidget _builder;

  @override
  WidgetBuilder get sliverBuilder => (context) => SliverToBoxAdapter(
        child: _builder(context),
      );

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [builder];

  @override
  bool? get stringify => true;
}
