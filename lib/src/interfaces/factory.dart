import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:widgets_from_html/widgets_from_html.dart' show IHtmlWidget;

/// An interface for creating instances of [IHtmlWidget].
abstract interface class IHtmlWidgetFactory<Widget extends IHtmlWidget>
    extends Equatable {
  /// Creates a new instance of [IHtmlWidgetFactory].
  const IHtmlWidgetFactory(this.builder);

  const factory IHtmlWidgetFactory.unsupported(dom.Node node) =
      UnsupportedHtmlWidgetFactory;

  /// Creates a new instance of [IHtmlWidget] from the given [dom.Node].
  final WidgetBuilder builder;

  @override
  List<Object?> get props => [builder];
}

/// A factory for creating unsupported instances of [IHtmlWidget].
///
class UnsupportedHtmlWidgetFactory<T extends IHtmlWidget>
    implements IHtmlWidgetFactory<T> {
  /// Creates a new instance of [UnsupportedHtmlWidgetFactory].
  const UnsupportedHtmlWidgetFactory(this.node);

  /// The node that is not supported.
  final dom.Node node;

  @override
  WidgetBuilder get builder => (context) => kDebugMode
      ? Text(
          'Unsupported node: $node',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        )
      : const SizedBox.shrink();

  @override
  List<Object?> get props => [node];

  @override
  bool? get stringify => true;
}
