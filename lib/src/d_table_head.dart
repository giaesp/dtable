import 'package:dtable/src/d_table_head_cell.dart';
import 'package:flutter/material.dart';

class DTableHead extends StatelessWidget {
  final ScrollController scrollController;
  final double height;
  final List<double> widths;
  final List<String> data;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color columnDividerColor;
  final double columnDividerWidth;
  final Color rowDividerColor;
  final double rowDividerWidth;

  const DTableHead(
      {Key? key,
      required this.scrollController,
      required this.data,
      required this.widths,
      required this.height,
      this.backgroundColor = const Color(0x00000000),
      this.columnDividerColor = const Color(0x00000000),
      this.columnDividerWidth = 0.0,
      this.rowDividerColor = const Color(0x00000000),
      this.rowDividerWidth = 0.0,
      this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: ListView.builder(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (listViewContext, i) {
              return DTableHeadCell(
                  backgroundColor: backgroundColor,
                  columnDividerColor: columnDividerColor,
                  columnDividerWidth: columnDividerWidth,
                  rowDividerColor: rowDividerColor,
                  rowDividerWidth: rowDividerWidth,
                  padding: padding,
                  width: widths[i],
                  content: Text(
                    data[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ));
            }));
  }
}
