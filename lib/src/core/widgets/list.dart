import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

final class ListHtmlWidget extends StatelessWidget implements IHtmlWidget {
  const ListHtmlWidget({
    super.key,
    required this.children,
    this.styles,
  });

  final Styles? styles;

  final List<ListItemHtmlWidget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: padding,
        shrinkWrap: true,
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }

  @override
  EdgeInsets get margin => styles?.margin ?? EdgeInsets.zero;

  @override
  EdgeInsets get padding => styles?.padding ?? EdgeInsets.zero;
}
