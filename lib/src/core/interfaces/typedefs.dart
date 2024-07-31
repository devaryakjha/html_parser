import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

typedef UnsupportedParser = IHtmlWidgetFactory<IHtmlWidget>? Function(
    dom.Node node);

typedef WidgetFactoryMapValue = IHtmlWidgetFactory Function(
  dom.Node,
  UnsupportedParser,
);

typedef WidgetFactoryKey = String;

typedef WidgetFactoryMap = Map<WidgetFactoryKey, WidgetFactoryMapValue>;

typedef OnLinkTap = void Function(String? href);

typedef StylesMap = Map<String, Styles>;
