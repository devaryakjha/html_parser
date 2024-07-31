import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart' show PhotoView;

/// A widget that displays a child widget in full screen when tapped.
class FullScreenWidget extends StatelessWidget {
  /// Creates a [FullScreenWidget].
  const FullScreenWidget({
    required this.child,
    super.key,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
  });

  /// The child widget to display in full screen.
  final Widget child;

  /// The background color of the full screen page.
  final Color backgroundColor;

  /// Whether the background of the full screen page is transparent.
  final bool backgroundIsTransparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder<void>(
            opaque: false,
            barrierColor:
                backgroundIsTransparent ? Colors.transparent : backgroundColor,
            pageBuilder: (BuildContext context, _, __) {
              return FullScreenPage(
                backgroundColor: backgroundColor,
                backgroundIsTransparent: backgroundIsTransparent,
                child: child,
              );
            },
          ),
        );
      },
      child: child,
    );
  }
}

///
class FullScreenPage extends StatelessWidget {
  ///
  const FullScreenPage({
    required this.child,
    super.key,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
  });

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
        leading: const CloseButton(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: PhotoView.customChild(child: child),
    );
  }
}
