import 'package:html/dom.dart' show Document, Element, Node, Text;

export 'src/core_html_parser.dart';
export 'src/core_html_view.dart';
export 'src/factories/factories.dart';
export 'src/interfaces/interfaces.dart';
export 'src/widgets/widgets.dart';

/// Represents a HTML Node.
///
/// redirects to [Node] from `package:html/dom.dart`.
typedef HtmlNode = Node;

/// Represents a HTML Element.
///
/// redirects to [Element] from `package:html/dom.dart`.
typedef HtmlElement = Element;

/// Represents a HTML Text Node.
///
/// redirects to [Text] from `package:html/dom.dart`.
typedef HtmlText = Text;

/// Represents a HTML Document.
///
/// redirects to [Document] from `package:html/dom.dart`.
typedef HtmlDocument = Document;
