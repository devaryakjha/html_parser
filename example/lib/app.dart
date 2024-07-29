import 'package:flutter/material.dart';

import 'utils/router.dart';

class HtmlToFlutterExample extends StatelessWidget {
  const HtmlToFlutterExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Html to Flutter Example',
      routerConfig: router,
    );
  }
}
