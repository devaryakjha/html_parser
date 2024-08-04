import 'package:flutter/widgets.dart';
import 'package:widgets_from_html/widgets_from_html.dart';
import 'package:widgets_from_html_example/widgets/full_screen_widget.dart';

/// A widget factory that is used to render and [ImageHtmlWidget]
///
/// represents `<img>` tag.
final class CustomImageFactory implements IHtmlWidgetFactory<ImageHtmlWidget> {
  /// Creates a new instance of [CustomImageFactory].
  const CustomImageFactory(this._builder);

  /// Creates a new instance of [CustomImageFactory] from a [HtmlNode].
  factory CustomImageFactory.fromNode(HtmlNode node) {
    final src = node.attributes['src'];
    final alt = node.attributes['alt'];
    final title = node.attributes['title'];
    final width = node.attributes['width'];
    final height = node.attributes['height'];

    return CustomImageFactory(
      (context) {
        final config = HtmlConfig.of(context);
        final styles = node is HtmlElement
            ? config.styles.getStyle(node.localName, config.defaultTextStyle)
            : null;

        return FullScreenWidget(
          title: alt ?? title,
          heroTag: src ?? UniqueKey(),
          child: ImageHtmlWidget(
            style: styles,
            src: src,
            alt: alt,
            title: title,
            width: width != null ? num.tryParse(width)?.toDouble() : null,
            height: height != null ? num.tryParse(height)?.toDouble() : null,
          ),
        );
      },
    );
  }

  final WidgetBuilder _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  WidgetBuilder get sliverBuilder => (context) => SliverToBoxAdapter(
        child: builder(context),
      );

  @override
  List<Object?> get props => [_builder];

  @override
  bool? get stringify => true;
}
