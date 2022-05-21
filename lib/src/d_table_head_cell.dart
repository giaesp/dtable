import 'package:flutter/material.dart';

class DTableHeadCell extends StatefulWidget {
  final Widget content;
  final double width;
  final double minWidth;
  final EdgeInsets padding;
  final Color columnDividerColor;
  final double columnDividerWidth;
  final Color rowDividerColor;
  final double rowDividerWidth;
  final Color backgroundColor;

  const DTableHeadCell(
      {Key? key,
      required this.content,
      required this.width,
      this.minWidth = 80.0,
      this.padding = EdgeInsets.zero,
      this.backgroundColor = const Color(0x00000000),
      this.columnDividerColor = const Color(0x00000000),
      this.columnDividerWidth = 0.0,
      this.rowDividerColor = const Color(0x00000000),
      this.rowDividerWidth = 0.0})
      : super(key: key);

  @override
  DTableHeadCellState createState() => DTableHeadCellState();
}

class DTableHeadCellState extends State<DTableHeadCell> {
  late Offset _columnLeftPosition;
  late Offset _columnRightPosition;
  bool _isPointMoving = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          child: Container(
              decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  border: Border(
                    right: BorderSide(width: widget.columnDividerWidth, color: widget.columnDividerColor),
                    bottom: BorderSide(width: widget.rowDividerWidth, color: widget.rowDividerColor),
                  )),
              width: widget.width,
              child: Padding(padding: widget.padding, child: widget.content))),
      Positioned(
          right: -5,
          child: Listener(
              onPointerDown: _handleOnPointDown,
              onPointerMove: _handleOnPointMove,
              onPointerUp: _handleOnPointUp,
              child: const IconButton(
                padding: EdgeInsets.zero,
                iconSize: 18.0,
                icon: Icon(Icons.dehaze),
                color: Color(0x00000000),
                mouseCursor: SystemMouseCursors.resizeLeftRight,
                onPressed: null,
              )))
    ]);
  }

  void _handleOnPointDown(PointerDownEvent event) {
    _isPointMoving = false;

    _columnRightPosition = event.position;
    _columnLeftPosition = _columnRightPosition - Offset(widget.width, 0);

    print('pointdown $_columnRightPosition $_columnLeftPosition');
  }

  void _handleOnPointMove(PointerMoveEvent event) {
    _isPointMoving = _columnRightPosition - event.position != Offset.zero;

    if (_isPointMoving && _columnLeftPosition.dx + widget.minWidth > event.position.dx) {
      return;
    }

    final moveOffset = event.position.dx - _columnRightPosition.dx;

    print('moveOffset $moveOffset');

/*
    widget.stateManager.resizeColumn(
      widget.column,
      moveOffset,
      checkScroll: false,
    );

    widget.stateManager.scrollByDirection(
      PlutoMoveDirection.right,
      widget.stateManager.isInvalidHorizontalScroll
          ? widget.stateManager.scroll!.maxScrollHorizontal
          : widget.stateManager.scroll!.horizontal!.offset,
    );
*/
    _columnRightPosition = event.position;
  }

  void _handleOnPointUp(PointerUpEvent event) {
    if (_isPointMoving) {
      // widget.stateManager.updateCorrectScroll();
    }

    _isPointMoving = false;
  }
}
