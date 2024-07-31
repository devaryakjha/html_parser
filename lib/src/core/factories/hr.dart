import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

typedef HrHtmlWidget = Divider Function(BuildContext);

final class HrHtmlWidgetFactory implements IHtmlWidgetFactory {
  const HrHtmlWidgetFactory(this._builder);

  final HrHtmlWidget _builder;

  factory HrHtmlWidgetFactory.fromNode(
    final dom.Node node,
    final UnsupportedParser unsupportedParser,
  ) {
    return HrHtmlWidgetFactory(
      (context) => const Divider(
        thickness: 2,
        height: 1,
        color: Colors.black,
      ),
    );
  }

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [builder];

  @override
  bool? get stringify => true;
}
