/// The base class for parsed data.
abstract class ParsedResultBase<T> {
  /// The parsed data.
  List<T> get data;

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
