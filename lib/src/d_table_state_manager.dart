import 'package:dtable/dtable.dart';
import 'package:dtable/src/d_table_column.dart';
import 'package:dtable/src/d_table_row.dart';
import 'package:flutter/widgets.dart';

class DTableStateManager extends DTableState {
  DTableStateManager({
    required List<DTableColumn> columns,
    required List<DTableRow> rows,
    required FocusNode? gridFocusNode,
  });
}
