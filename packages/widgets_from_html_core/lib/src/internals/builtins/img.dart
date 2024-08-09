import 'package:flutter/material.dart';
import 'package:widgets_from_html_core/widgets_from_html_core.dart';

/// Extension for `img` tag.
final class ImageExtension extends HtmlExtension {
  /// Creates a new instance of [ImageExtension].
  const ImageExtension();

  @override
  Set<String> get supportedTags => {'img'};

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

  Image _createImage(
    String src,
    String? alt,
    String? title,
    double? width,
    double? height,
  ) {
    return Image.network(
      src,
      errorBuilder: (context, error, stackTrace) {
        if (alt == null || alt.isEmpty) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: const Icon(Icons.error, color: Colors.red),
          );
        }

        return Text(alt);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return _loader(loadingProgress);
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          opacity: frame == null ? 0 : 1,
          child: child,
        );
      },
    );
  }

  Widget _createWidget(Node node, HtmlConfig config) {
    final element = node as HTMLElement;
    final src = element.attributes['src'];
    final alt = element.attributes['alt'];
    final title = element.attributes['title'];
    final width = num.tryParse(element.attributes['width'] ?? '')?.toDouble();
    final height = num.tryParse(element.attributes['height'] ?? '')?.toDouble();
    if (src == null) return const SizedBox.shrink();
    final aspectRation =
        width != null && height != null ? width / height : null;
    if (aspectRation != null) {
      return AspectRatio(
        aspectRatio: width != null && height != null ? width / height : 1,
        child: _createImage(src, alt, title, width, height),
      );
    }
    return _createImage(src, alt, title, width, height);
  }

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    return ParsedResult(
      source: node,
      builder: (context) => _createWidget(node, config),
    );
  }
}
