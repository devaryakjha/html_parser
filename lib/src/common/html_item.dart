import 'package:flutter/widgets.dart';

abstract class HtmlItem extends StatelessWidget {
  const HtmlItem({super.key});

  /// Builds a widget with the given index.
  Widget buildWithIndex(BuildContext context, int index);
}
