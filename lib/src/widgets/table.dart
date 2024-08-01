import 'package:flutter/material.dart';
import 'package:widgets_from_html/widgets_from_html.dart';

/// A widget that is used to render a table.
///
/// represents `<table>` tag.
final class TableHtmlWidget extends StatelessWidget implements IHtmlWidget {
  /// Creates a new instance of [TableHtmlWidget].
  const TableHtmlWidget({
    required this.columns,
    required this.rows,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final config = HtmlConfig.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(left: margin.left)),
          DataTable(
            columns: columns,
            rows: rows,
            border: TableBorder.all(
              color: config.defaultTextStyle.color ?? Colors.black,
            ),
            dataRowMaxHeight: double.infinity,
          ),
          Padding(padding: EdgeInsets.only(right: margin.right)),
        ],
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
