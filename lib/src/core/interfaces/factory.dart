import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart' show IHtmlWidget;

/// An interface for creating instances of [IHtmlWidget].
abstract interface class IHtmlWidgetFactory<Widget extends IHtmlWidget>
    extends Equatable {
  /// Creates a new instance of [IHtmlWidgetFactory].
  const IHtmlWidgetFactory(this.builder);

  /// Creates a new instance of [IHtmlWidget] from the given [node].
  final WidgetBuilder builder;

  /// Creates a new instance of [IHtmlWidgetFactory] from the given [node].
  IHtmlWidgetFactory.fromNode(final dom.Node node)
      : builder = ((context) => const IHtmlWidget.placeholder() as Widget);

  @override
  List<Object?> get props => [builder];
}
