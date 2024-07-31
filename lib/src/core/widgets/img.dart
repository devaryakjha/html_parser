import 'package:flutter/material.dart';
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

  Widget _wrapInAspectRation(Widget child) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
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

  double get aspectRatio =>
      width != null && height != null ? width! / height! : 16 / 9;

  @override
  EdgeInsets? get margin => style?.margin;

  @override
  EdgeInsets? get padding => style?.padding;
}
