// ignore_for_file: public_member_api_docs

import 'package:html/dom.dart' as dom;
import 'package:widgets_from_html/widgets_from_html.dart';

typedef UnsupportedParser = IHtmlWidgetFactory<IHtmlWidget>? Function(
  dom.Node node,
);

typedef WidgetFactoryMapValue = IHtmlWidgetFactory Function(
  dom.Node node,
  UnsupportedParser parser,
);

typedef WidgetFactoryKey = String;

typedef WidgetFactoryMap = Map<WidgetFactoryKey, WidgetFactoryMapValue>;

typedef OnLinkTap = void Function(String? href);

typedef StylesMap = Map<String, Styles>;
