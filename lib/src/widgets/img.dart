import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render an image.
///
/// represents `<img>` tag.
final class ImageHtmlWidget extends StatelessWidget with IHtmlWidget {
  /// Creates a new instance of [ImageHtmlWidget].
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

  /// The source of the image.
  final String? src;

  /// The alternative text for the image.
  final String? alt;

  /// The title of the image.
  final String? title;

  /// The width of the image.
  final double? width;

  /// The height of the image.
  final double? height;

  Widget _wrapInAspectRation(Widget child) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return wrapInAlignment(
      Image.network(
        src ?? '',
        errorBuilder: (context, error, stackTrace) {
          if (alt == null || alt!.isEmpty) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: const Icon(Icons.error, color: Colors.red),
            );
          }

          return Text(alt ?? '');
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return _wrapInAspectRation(_loader(loadingProgress));
        },
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return _wrapInAspectRation(child);
          }

          return _wrapInAspectRation(
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              opacity: frame == null ? 0 : 1,
              child: child,
            ),
          );
        },
      ),
    );
  }

  Center _loader(ImageChunkEvent loadingProgress) {
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }

  /// The aspect ratio of the image.
  double get aspectRatio =>
      width != null && height != null ? width! / height! : 16 / 9;

  @override
  Styles get styles => style ?? super.styles;
}
