import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

typedef HrHtmlWidget = Divider Function(BuildContext);

final class HrHtmlWidgetFactory implements IHtmlWidgetFactory {
  const HrHtmlWidgetFactory(this._builder);

  factory HrHtmlWidgetFactory.fromNode() {
    return HrHtmlWidgetFactory(
      (context) => const Divider(
        thickness: 2,
        height: 1,
        color: Colors.black,
      ),
    );
  }

  final HrHtmlWidget _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [builder];

  @override
  bool? get stringify => true;
}
