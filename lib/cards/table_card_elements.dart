import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TableRow extends StatelessWidget {
  const TableRow({
    Key? key,
    required this.mainDecoration,
    required this.textColor,
    required this.tableTitle,
    required this.children,
  }) : super(key: key);

  final BoxDecoration mainDecoration;
  final Color textColor;
  final String tableTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              decoration: mainDecoration,
              child: Center(
                child: Text(
                  tableTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
          ...children
        ],
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  const TableCell({
    Key? key,
    required this.mainDecoration,
    required this.textColor,
    required this.content,
  }) : super(key: key);

  final BoxDecoration mainDecoration;
  final Color textColor;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        decoration: mainDecoration,
        child: Center(
          child: Text(
            content,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class TableCellEditable extends StatefulWidget {
  const TableCellEditable({
    Key? key,
    required this.value,
    required this.mainDecoration,
    required this.textColor,
    required this.focusNode,
    required this.nextFocusNode,
    required this.onChanged,
  }) : super(key: key);

  final String? value;
  final BoxDecoration mainDecoration;
  final Color textColor;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final void Function(String value) onChanged;

  @override
  State<TableCellEditable> createState() => _TableCellEditableState();
}

class _TableCellEditableState extends State<TableCellEditable> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
    widget.focusNode.addListener(onSelection);
  }

  void onSelection() {
    if (widget.focusNode.hasFocus) {
      controller.selection =
          TextSelection(baseOffset: 0, extentOffset: controller.text.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.text != widget.value) {
      controller.text = widget.value ?? '';
    }
    return Expanded(
      child: Container(
        height: double.infinity,
        decoration: widget.mainDecoration,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: TextField(
              focusNode: widget.focusNode,
              controller: controller,
              textAlign: TextAlign.center,
              maxLength: 3,
              keyboardType: TextInputType.phone, // TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  FocusScope.of(context).requestFocus(widget.nextFocusNode);
                }
              },
              onChanged: (value) {
                widget.onChanged(value);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(5),
                border: OutlineInputBorder(),
                counterText: "",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    widget.focusNode.removeListener(onSelection);
    super.dispose();
  }
}

class TableHeader extends StatelessWidget {
  final BorderSide mainBorderSide;
  final Color textColor;
  final String title;

  const TableHeader({
    Key? key,
    required this.mainBorderSide,
    required this.textColor,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          top: mainBorderSide,
          bottom: mainBorderSide,
          left: mainBorderSide,
        ),
      ),
      child: Center(
          child: Text(title,
              style: TextStyle(
                color: textColor,
              ))),
    );
  }
}
