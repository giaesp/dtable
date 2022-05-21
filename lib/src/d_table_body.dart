import 'package:dtable/src/d_table_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class DTableBody extends StatefulWidget {
  final ScrollController scrollController;
  final List<double> widths;
  final List<List<String>> data;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color alternateBackgroundColor;
  final Color columnDividerColor;
  final double columnDividerWidth;
  final Color rowDividerColor;
  final double rowDividerWidth;

  const DTableBody({
    Key? key,
    required this.scrollController,
    required this.widths,
    required this.data,
    this.backgroundColor = const Color(0x00000000),
    this.alternateBackgroundColor = const Color(0x00000000),
    this.columnDividerColor = const Color(0x00000000),
    this.columnDividerWidth = 0.0,
    this.rowDividerColor = const Color(0x00000000),
    this.rowDividerWidth = 0.0,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  TableBodyState createState() => TableBodyState();
}

class TableBodyState extends State<DTableBody> {
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _restColumnsController;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _restColumnsController = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _restColumnsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: widget.scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
            width: widget.widths.reduce((a, b) => a + b),
            child: ListView.builder(
                controller: _restColumnsController,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.data.length,
                itemBuilder: (listViewContext, i) {
                  return Container(
                      color: i % 2 == 0 ? widget.backgroundColor : widget.alternateBackgroundColor,
                      child: Row(
                          children: List.generate(widget.data[i].length, (value) {
                        return DTableCell(
                            columnDividerColor: widget.columnDividerColor,
                            columnDividerWidth: widget.columnDividerWidth,
                            padding: widget.padding,
                            width: widget.widths[value],
                            content: Text(
                              widget.data[i][value],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ));
                      })));
                })));
  }
}
