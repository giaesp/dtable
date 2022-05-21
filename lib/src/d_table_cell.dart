import 'package:flutter/widgets.dart';

class DTableCell extends StatelessWidget {
  final Widget? content;
  final double width;
  final EdgeInsets padding;
  final Color columnDividerColor;
  final double columnDividerWidth;
  final Color rowDividerColor;
  final double rowDividerWidth;
  final Color backgroundColor;

  const DTableCell(
      {Key? key,
      this.content,
      required this.width,
      this.padding = EdgeInsets.zero,
      this.backgroundColor = const Color(0x00000000),
      this.columnDividerColor = const Color(0x00000000),
      this.columnDividerWidth = 0.0,
      this.rowDividerColor = const Color(0x00000000),
      this.rowDividerWidth = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return content != null
        ? Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                border: Border(
                  right: BorderSide(width: columnDividerWidth, color: columnDividerColor),
                  bottom: BorderSide(width: rowDividerWidth, color: rowDividerColor),
                )),
            width: width,
            child: Padding(padding: padding, child: content))
        : Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                border: Border(
                  right: BorderSide(width: columnDividerWidth, color: columnDividerColor),
                  bottom: BorderSide(width: rowDividerWidth, color: rowDividerColor),
                )),
            width: width,
          );
  }
}
