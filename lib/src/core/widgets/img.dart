import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

final class ImageHtmlWidget extends StatelessWidget implements IHtmlWidget {
  const ImageHtmlWidget({
    super.key,
    this.style,
    this.src,
    this.alt,
    this.title,
    this.width,
    this.height,
  });

  /// The [Styles] to use for the widget.
  final Styles? style;
  final String? src;
  final String? alt;
  final String? title;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Image.network(src!),
    );
  }

  double get aspectRatio =>
      width != null && height != null ? width! / height! : 16 / 9;

  @override
  EdgeInsets? get margin => style?.margin;

  @override
  EdgeInsets? get padding => style?.padding;
}
