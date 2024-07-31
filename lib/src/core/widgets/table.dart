import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

final class TableHtmlWidget extends StatelessWidget implements IHtmlWidget {
  const TableHtmlWidget({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns,
        rows: rows,
        border: TableBorder.all(),
      ),
    );
  }

  /// The columns in the table.
  final List<DataColumn> columns;

  /// The rows in the table.
  final List<DataRow> rows;

  @override
  EdgeInsets get margin => EdgeInsets.zero;

  @override
  EdgeInsets get padding => EdgeInsets.zero;
}
