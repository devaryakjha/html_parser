import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// The base class for parsed data.
@immutable
abstract class ParsedResultBase<T extends HtmlWidgetBuilder> {
  const ParsedResultBase(this.data, {this.source = ''});

  /// The parsed data.
  final List<T> data;

  /// The source of the parsed data.
  final String source;

  /// Whether the parsed data is empty.
  bool get hasData => data.isNotEmpty;

  /// Whether the parsed data is empty.
  bool get hasNoData => !hasData;

  /// Whether the parsed data has a single element.
  bool get hasSingleData => length == 1;

  /// The single parsed data.
  T get singleData => data.first;

  /// The first parsed data.
  T get firstData => data.first;

  /// The last parsed data.
  T get lastData => data.last;

  /// The parsed data at the given index.
  T operator [](int index) => data[index];

  /// The length of the parsed data.
  int get length => data.length;
}

class ParsedResult extends ParsedResultBase<HtmlWidgetBuilder> {
  const ParsedResult(super.data, {super.source});
}
