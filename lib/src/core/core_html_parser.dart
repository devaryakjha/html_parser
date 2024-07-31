import 'package:html_to_flutter/html_to_flutter.dart'
    show IHtmlWidget, IHtmlWidgetFactory, IHtmlParser, HtmlConfig;

final class HtmlParser implements IHtmlParser {
  const HtmlParser(this._config);

  final HtmlConfig _config;

  @override
  HtmlConfig get config => _config;

  @override
  List<IHtmlWidgetFactory<IHtmlWidget>> parse(String html) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
