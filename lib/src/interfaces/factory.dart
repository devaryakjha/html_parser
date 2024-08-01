import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart' show IHtmlWidget;

/// An interface for creating instances of [IHtmlWidget].
abstract interface class IHtmlWidgetFactory<Widget extends IHtmlWidget>
    extends Equatable {
  /// Creates a new instance of [IHtmlWidgetFactory].
  const IHtmlWidgetFactory(this.builder);

  /// Creates a new instance of [IHtmlWidget] from the given [node].
  final WidgetBuilder builder;

  const factory IHtmlWidgetFactory.withBuilder(
    final WidgetBuilder builder,
  ) = _CustomHtmlWidgetFactory;

  const factory IHtmlWidgetFactory.unsupported(final dom.Node node) =
      UnsupportedHtmlWidgetFactory;

  @override
  List<Object?> get props => [builder];
}

class _CustomHtmlWidgetFactory<T extends IHtmlWidget>
    implements IHtmlWidgetFactory<T> {
  const _CustomHtmlWidgetFactory(this._builder);

  final WidgetBuilder _builder;

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [builder];

  @override
  bool? get stringify => true;
}

/// A factory for creating unsupported instances of [IHtmlWidget].
///
class UnsupportedHtmlWidgetFactory<T extends IHtmlWidget>
    implements IHtmlWidgetFactory<T> {
  const UnsupportedHtmlWidgetFactory(this.node);

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
