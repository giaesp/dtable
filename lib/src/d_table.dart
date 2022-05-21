import 'dart:ui';

import 'package:dtable/src/d_table_body.dart';
import 'package:dtable/src/d_table_head.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class DTable extends StatefulWidget {
  final List<List<String>> data;
  final BoxDecoration? decoration;
  final EdgeInsets headerCellPadding;
  final EdgeInsets bodyCellPadding;
  final Color columnDividerColor;
  final double columnDividerWidth;
  final Color rowDividerColor;
  final double rowDividerWidth;
  final bool fitColumns;

  const DTable(
      {Key? key,
      required this.data,
      this.decoration,
      this.headerCellPadding = EdgeInsets.zero,
      this.bodyCellPadding = EdgeInsets.zero,
      this.columnDividerColor = const Color(0x00000000),
      this.columnDividerWidth = 0.0,
      this.rowDividerColor = const Color(0x00000000),
      this.rowDividerWidth = 0.0,
      this.fitColumns = false})
      : super(key: key);

  @override
  DTableState createState() => DTableState();
}

class DTableState extends State<DTable> {
  static const _cellFix = 10.0;

  late LinkedScrollControllerGroup _controllers;
  late ScrollController _headController;
  late ScrollController _bodyController;

  final _cellSizes = <List<Size>>[];

  late List<double> _cellMaxs;
  late double _cellTotal;

  @override
  void initState() {
    /*
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      
    });
    */
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _headController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initializeData();
    return Focus(
        child: ScrollConfiguration(
            behavior: const DTableScrollBehavior().copyWith(
              scrollbars: false,
            ),
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: widget.decoration,
                child: FocusScope(child: SafeArea(child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (widget.fitColumns || constraints.maxWidth >= _cellTotal) {
                      _cellMaxs = List<double>.filled(
                          widget.data[0].length, constraints.maxWidth / widget.data[0].length,
                          growable: false);
                    }

                    return Column(children: [
                      DTableHead(
                        data: widget.data.first,
                        height: 32.0,
                        widths: _cellMaxs,
                        scrollController: _headController,
                        padding: widget.headerCellPadding,
                        rowDividerColor: widget.rowDividerColor,
                        rowDividerWidth: widget.rowDividerWidth,
                        columnDividerColor: widget.columnDividerColor,
                        columnDividerWidth: widget.columnDividerWidth,
                        backgroundColor: const Color(0xFF902173),
                      ),
                      Expanded(
                        child: DTableBody(
                          data: widget.data.sublist(1, widget.data.length - 1),
                          widths: _cellMaxs,
                          scrollController: _bodyController,
                          padding: widget.headerCellPadding,
                          rowDividerColor: widget.rowDividerColor,
                          rowDividerWidth: widget.rowDividerWidth,
                          columnDividerColor: widget.columnDividerColor,
                          columnDividerWidth: widget.columnDividerWidth,
                          backgroundColor: const Color(0xFF2389CD),
                        ),
                      ),
                    ]);
                  },
                ))))));
  }

  _initializeData() {
    final padding = _checkPaddings();
    _cellMaxs = List<double>.filled(widget.data[0].length, 0.0, growable: false);
    for (var i = 0; i < widget.data.length; i++) {
      var temp = <Size>[];
      for (var j = 0; j < widget.data[i].length; j++) {
        final size = _textSize(widget.data[i][j], null);
        final width = size.width + padding + _cellFix;
        if (width > _cellMaxs[j]) _cellMaxs[j] = width;
        temp.add(size);
      }
      _cellSizes.add(temp);
    }
    _cellTotal = _cellMaxs.reduce((a, b) => a + b);
  }

  _checkPaddings() {
    var maxPadding = widget.columnDividerWidth;
    if (widget.headerCellPadding.left + widget.headerCellPadding.right > maxPadding) {
      maxPadding = widget.headerCellPadding.left + widget.headerCellPadding.right;
    }
    if (widget.bodyCellPadding.left + widget.bodyCellPadding.right > maxPadding) {
      maxPadding = widget.bodyCellPadding.left + widget.bodyCellPadding.right;
    }
    return maxPadding;
  }

  Size _textSize(String text, TextStyle? style) {
    final textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0.0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

class DTableScrollBehavior extends MaterialScrollBehavior {
  const DTableScrollBehavior() : super();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
