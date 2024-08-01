import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html_to_flutter/html_to_flutter.dart';

/// A factory that is used to render a [TableHtmlWidget].
///
/// represents `<table>` tag.
final class TableHtmlWidgetFactory
    implements IHtmlWidgetFactory<TableHtmlWidget> {
  /// Creates a new instance of [TableHtmlWidgetFactory].
  const TableHtmlWidgetFactory(this._builder);

  /// Creates a new instance of [TableHtmlWidgetFactory] from a [dom.Node].
  factory TableHtmlWidgetFactory.fromNode(
    dom.Node node,
    UnsupportedParser unsupportedParser,
  ) {
    final allNodes = node.nodes.whereType<dom.Element>().toList();
    final thead = allNodes.firstWhereOrNull((e) => e.localName == 'thead');
    final tbody = allNodes.firstWhereOrNull((e) => e.localName == 'tbody');
    final columns = thead != null
        ? _createColumnsFromThead(thead, unsupportedParser)
        : _createColumnsFromTbody(tbody!, unsupportedParser);
    final rows = _createRowsFromTbody(
      tbody!,
      unsupportedParser,
      omitFirstRow: thead == null,
    );

    final maxColumns = columns.length;

    // if maxColumns is less than the number of cells in the rows
    // then fill the columns with empty cells
    final maxRowColumns = rows.fold<int>(
      0,
      (previousValue, element) => math.max(element.cells.length, previousValue),
    );

    if (maxColumns < maxRowColumns) {
      columns.addAll(
        List.generate(
          maxRowColumns - maxColumns,
          (index) => const DataColumn(label: Text(' ')),
        ),
      );
    }

    // now that the columns are filled with empty cells
    // lets check the rows and fill them with empty cells if needed

    for (final row in rows) {
      final maxColumns = columns.length;
      final missingColumns = maxColumns - row.cells.length;
      if (missingColumns > 0) {
        row.cells.addAll(
          List.generate(
            missingColumns,
            (index) => DataCell(
              Builder(
                builder: (ctx) => const Text('-'),
              ),
            ),
          ),
        );
      }
    }

    return TableHtmlWidgetFactory((context) {
      return TableHtmlWidget(
        columns: columns,
        rows: rows,
      );
    });
  }

  /// The [WidgetBuilder] to use for the widget.
  final WidgetBuilder _builder;

  /// Creates the columns from the HTML nodes.
  static List<DataColumn> _createColumnsFromThead(
    dom.Element nodes,
    UnsupportedParser unsupportedParser,
  ) {
    final tr = nodes.nodes
        .whereType<dom.Element>()
        .firstWhereOrNull((e) => e.localName == 'tr');
    final allThs = tr?.nodes.whereType<dom.Element>().toList() ?? [];
    return allThs
        .map(
          (e) => DataColumn(
            label: Expanded(
              child: Builder(
                builder: unsupportedParser(e)?.builder ??
                    (ctx) => const SizedBox.shrink(),
              ),
            ),
            tooltip: e.attributes['title'] ?? e.text,
          ),
        )
        .toList();
  }

  static List<DataColumn> _createColumnsFromTbody(
    dom.Element nodes,
    UnsupportedParser unsupportedParser,
  ) {
    final tr = nodes.nodes
        .whereType<dom.Element>()
        .where((e) => e.text.trim().isNotEmpty)
        .firstWhereOrNull((e) => e.localName == 'tr');
    final allTds = tr?.nodes.whereType<dom.Element>().toList() ?? [];
    return allTds
        .map(
          (td) => DataColumn(
            label: Expanded(
              child: Builder(
                builder: (ctx) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: unsupportedParser(td)?.builder(ctx),
                ),
              ),
            ),
            tooltip: td.attributes['title'] ?? td.text,
          ),
        )
        .toList();
  }

  static List<DataRow> _createRowsFromTbody(
    dom.Element nodes,
    UnsupportedParser unsupportedParser, {
    bool omitFirstRow = false,
  }) {
    final trs = nodes.nodes.whereType<dom.Element>().toList();

    if (omitFirstRow) {
      trs.removeAt(0);
    }

    final rows = <DataRow>[];

    final fillRowWith = <int, Map<int, DataCell>>{};

    for (final trIndexed in trs.indexed) {
      final (index, tr) = trIndexed;
      final tds = tr.nodes.whereType<dom.Element>().toList();
      final cells = fillRowWith[index]?.values.toList() ?? [];
      for (final tdIndexed in tds.indexed) {
        final (jindex, td) = tdIndexed;
        final rowSpan = int.tryParse(td.attributes['rowspan'] ?? '1') ?? 1;
        cells.add(
          DataCell(
            Builder(
              builder: (ctx) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: SizedBox(
                  width: 300,
                  child: unsupportedParser(td)?.builder(ctx),
                ),
              ),
            ),
          ),
        );
        if (rowSpan > 1) {
          fillRowWith.addAll({
            for (int i = 1; i < rowSpan; i++) ...{
              index + i: {
                ...fillRowWith[index + i] ?? {},
                jindex: cells.last,
              },
            },
          });
        }
      }
      rows.add(DataRow(cells: cells));
    }

    return rows;
  }

  @override
  WidgetBuilder get builder => _builder;

  @override
  List<Object?> get props => [_builder];

  @override
  bool? get stringify => true;
}
