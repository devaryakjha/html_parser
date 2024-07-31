import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart' show PhotoView;

/// A widget that displays a child widget in full screen when tapped.
class FullScreenWidget extends StatelessWidget {
  /// Creates a [FullScreenWidget].
  const FullScreenWidget({
    required this.child,
    required this.heroTag,
    super.key,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    this.title,
  });

  /// The hero tag to use for the full screen page.
  final Object heroTag;

  /// The title of the full screen page.
  final String? title;

  /// The child widget to display in full screen.
  final Widget child;

  /// The background color of the full screen page.
  final Color backgroundColor;

  /// Whether the background of the full screen page is transparent.
  final bool backgroundIsTransparent;

  Hero _buildHero(Widget child) {
    return Hero(
      tag: heroTag,
      child: child,
    );
  }

  void _onTap(BuildContext context) {
    try {
      Navigator.push(
        context,
        PageRouteBuilder<void>(
          opaque: false,
          barrierColor:
              backgroundIsTransparent ? Colors.transparent : backgroundColor,
          pageBuilder: (BuildContext context, _, __) {
            return _FullScreenPage(
              backgroundColor: backgroundColor,
              backgroundIsTransparent: backgroundIsTransparent,
              title: title,
              child: _buildHero(child),
            );
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: _buildHero(child),
    );
  }
}

///
class _FullScreenPage extends StatelessWidget {
  ///
  const _FullScreenPage({
    required this.child,
    this.title,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
  });

  final String? title;

  ///
  final Widget child;

  ///
  final Color backgroundColor;

  ///
  final bool backgroundIsTransparent;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        backgroundIsTransparent ? Colors.transparent : backgroundColor;
    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: title != null ? Text(title!) : null,
        leading: const CloseButton(color: Colors.white),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: PhotoView.customChild(child: child),
    );
  }
}
