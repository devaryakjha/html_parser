// ignore_for_file: public_member_api_docs

import 'package:widgets_from_html/widgets_from_html.dart';

typedef UnsupportedParser = IHtmlWidgetFactory<IHtmlWidget>? Function(
  HtmlNode node,
);

typedef WidgetFactoryMapValue = IHtmlWidgetFactory Function(
  HtmlNode node,
  UnsupportedParser parser,
);

typedef WidgetFactoryKey = String;

typedef WidgetFactoryMap = Map<WidgetFactoryKey, WidgetFactoryMapValue>;

typedef OnLinkTap = void Function(String? href);

typedef StylesMap = Map<String, Styles>;
