import 'package:html/dom.dart' show Document, Element, Node, Text;

export 'src/core_html_parser.dart';
export 'src/core_html_view.dart';
export 'src/factories/factories.dart';
export 'src/interfaces/interfaces.dart';
export 'src/widgets/widgets.dart';

/// Represents a HTML Node.
typedef HtmlNode = Node;

/// Represents a HTML Element.
typedef HtmlElement = Element;

/// Represents a HTML Text Node.
typedef HtmlText = Text;

/// Represents a HTML Document.
typedef HtmlDocument = Document;
