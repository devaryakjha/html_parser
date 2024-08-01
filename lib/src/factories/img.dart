import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

/// A widget factory that is used to render and [ImageHtmlWidget]
///
/// represents `<img>` tag.
final class ImageHtmlWidgetFactory
    implements IHtmlWidgetFactory<ImageHtmlWidget> {
  /// Creates a new instance of [ImageHtmlWidgetFactory].
  const ImageHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [ImageHtmlWidgetFactory] from a [dom.Node].
  factory ImageHtmlWidgetFactory.fromNode(dom.Node node) {
    final src = node.attributes['src'];
    final alt = node.attributes['alt'];
    final title = node.attributes['title'];
    final width = node.attributes['width'];
    final height = node.attributes['height'];

    return ImageHtmlWidgetFactory(
      (context) {
        final config = HtmlConfig.of(context);
        final styles = node is dom.Element
            ? config.styles.getStyle(node.localName, config.defaultTextStyle)
            : null;

        return ImageHtmlWidget(
          style: styles,
          src: src,
          alt: alt,
          title: title,
          width: width != null ? num.tryParse(width)?.toDouble() : null,
          height: height != null ? num.tryParse(height)?.toDouble() : null,
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
  bool? get stringify => true;
}
