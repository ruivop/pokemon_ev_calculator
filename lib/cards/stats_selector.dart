import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_ev_calculator/data/stats.dart';
import 'package:pokemon_ev_calculator/reusable/card.dart';
import 'package:provider/provider.dart';

import '../state.dart';

class StatsSelector extends StatefulWidget {
  const StatsSelector({Key? key}) : super(key: key);

  @override
  State<StatsSelector> createState() => _StatsSelectorState();
}

class _StatsSelectorState extends State<StatsSelector> {
  final Color textColor = Colors.white;
  List<FocusNode> focusNodes = List<FocusNode>.generate(13, (i) => FocusNode());

  @override
  Widget build(BuildContext context) {
    var mainBorderSide = BorderSide(
      color: Colors.white.withAlpha(150),
    );
    var mainDecoration = BoxDecoration(
      //botther on the left
      border: Border(
        bottom: mainBorderSide,
        left: mainBorderSide,
      ),
    );
    return SelectionCard(
      header: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              Icon(
                CupertinoIcons.graph_circle,
                color: Colors.white.withAlpha(150),
                size: 16,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Stats",
                  style: TextStyle(
                    color: Colors.white.withAlpha(150),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                right: mainBorderSide,
              ),
            ),
            child: Row(
              children: [
                "",
                "HP",
                "ATK",
                "DEF",
                "SP. A",
                "SP. D",
                "SPD",
              ]
                  .map((header) => Expanded(
                          child: TableHeader(
                        title: header,
                        mainBorderSide: mainBorderSide,
                        textColor: textColor,
                      )))
                  .toList(),
              /*
                */
            ),
          )
        ],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(focusNodes[12]);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border(
              right: mainBorderSide,
            ),
          ),
          child: Consumer<CalculationState>(
            builder: (context, state, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TableRow(
                    tableTitle: "Nature Efect",
                    children: [
                      TableCell(
                        content: "",
                        mainDecoration: mainDecoration,
                        textColor: textColor,
                      ),
                      ...natures[state.pkmNature == null || state.pkmNature == 0
                              ? 1
                              : state.pkmNature!]
                          .map((multiplier) => TableCell(
                                content: multiplier == 1
                                    ? "-"
                                    : "x" + multiplier.toString(),
                                mainDecoration: mainDecoration,
                                textColor: textColor,
                              ))
                          .toList()
                    ],
                    mainDecoration: mainDecoration,
                    textColor: textColor),
                TableRow(
                    tableTitle: "Base Stats",
                    children: [
                      ...state.selectedPokemon.baseStats
                          .map((statVal) => TableCell(
                                content: statVal.toString(),
                                mainDecoration: mainDecoration,
                                textColor: textColor,
                              ))
                          .toList()
                    ],
                    mainDecoration: mainDecoration,
                    textColor: textColor),
                /*TableRow(
                    tableTitle: "Effort Points",
                    children: [
                      ...state.selectedPokemon.efortPoints
                          .map((ep) => TableCell(
                                content: ep == 0 ? "" : ep.toString(),
                                mainDecoration: mainDecoration,
                                textColor: textColor,
                              ))
                          .toList()
                    ],
                    mainDecoration: mainDecoration,
                    textColor: textColor),*/
                TableRow(
                    tableTitle: "Stats",
                    children: [
                      for (var i = 0; i < 6; i++)
                        TableCellEditable(
                          mainDecoration: mainDecoration,
                          textColor: textColor,
                          focusNode: focusNodes[i],
                          nextFocusNode: focusNodes[i + 1],
                          onChanged: (value) {
                            var newValue = int.tryParse(value);
                            Provider.of<CalculationState>(context,
                                    listen: false)
                                .setStat(i, newValue);
                          },
                        )
                    ],
                    mainDecoration: mainDecoration,
                    textColor: textColor),
                TableRow(
                    tableTitle: "IVs",
                    children: [
                      for (var i = 6; i < 12; i++)
                        TableCellEditable(
                          mainDecoration: mainDecoration,
                          textColor: textColor,
                          focusNode: focusNodes[i],
                          nextFocusNode: focusNodes[i + 1],
                          onChanged: (value) {
                            var newValue = int.tryParse(value);
                            Provider.of<CalculationState>(context,
                                    listen: false)
                                .setIV(i - 6, newValue);
                          },
                        )
                    ],
                    mainDecoration: mainDecoration,
                    textColor: textColor),
                TableRow(
                    tableTitle: "Result EVs",
                    children: [
                      ...state.resultEVs
                          .map((ep) => TableCell(
                                content: ep,
                                mainDecoration: mainDecoration,
                                textColor: textColor,
                              ))
                          .toList()
                    ],
                    mainDecoration: mainDecoration,
                    textColor: textColor)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}

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
    required this.mainDecoration,
    required this.textColor,
    required this.focusNode,
    required this.nextFocusNode,
    required this.onChanged,
  }) : super(key: key);

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
    controller = TextEditingController();
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
