import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_stats_calculator/cards/table_card_elements.dart' as my;
import 'package:pokemon_stats_calculator/data/stats.dart';
import 'package:pokemon_stats_calculator/reusable/card.dart';
import 'package:provider/provider.dart';

import '../state.dart';

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
const Color textColor = Colors.white;

class EVTableSelector extends StatefulWidget {
  const EVTableSelector({Key? key}) : super(key: key);

  @override
  State<EVTableSelector> createState() => _EVTableSelectorState();
}

class _EVTableSelectorState extends State<EVTableSelector> {
  List<FocusNode> statsFocusNodes =
      List<FocusNode>.generate(6, (i) => FocusNode());
  List<FocusNode> ivFocusNodes =
      List<FocusNode>.generate(6, (i) => FocusNode());
  List<FocusNode> evFocusNodes =
      List<FocusNode>.generate(6, (i) => FocusNode());
  FocusNode emptyFocusNode = FocusNode();

  FocusNode getFocusNode({
    required int i,
    bool isStats = false,
    bool isIV = false,
    bool isEv = false,
  }) {
    if (isStats) {
      return statsFocusNodes[i];
    } else if (isIV) {
      return ivFocusNodes[i];
    } else {
      return evFocusNodes[i];
    }
  }

  FocusNode getNextFocusNode({
    required int i,
    required CalculationType? type,
    bool isStats = false,
    bool isIV = false,
    bool isEv = false,
  }) {
    var nonNullTye = type ?? CalculationType.Stat;
    if (i != 5) {
      if (isStats) {
        return statsFocusNodes[i + 1];
      } else if (isIV) {
        return ivFocusNodes[i + 1];
      } else {
        return evFocusNodes[i + 1];
      }
    } else {
      if (nonNullTye == CalculationType.Stat) {
        if (isIV) {
          return evFocusNodes[0];
        } else {
          return emptyFocusNode;
        }
      } else if (nonNullTye == CalculationType.IV) {
        if (isStats) {
          return evFocusNodes[0];
        } else {
          return emptyFocusNode;
        }
      } else {
        //if (nonNullTye == CalculationType.EV)
        if (isStats) {
          return ivFocusNodes[0];
        } else {
          return emptyFocusNode;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          child: my.TableHeader(
                        title: header,
                        mainBorderSide: mainBorderSide,
                        textColor: textColor,
                        backgroundColor: Colors.black.withAlpha(60),
                      )))
                  .toList(),
              /*
                */
            ),
          ),
        ],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(emptyFocusNode);
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
                my.TableRow(
                    tableTitle: "Nature Efect",
                    children: [
                      my.TableCell(
                        content: "",
                        mainDecoration: mainDecoration,
                        textColor: textColor,
                      ),
                      ...natures[state.pkmNature == null || state.pkmNature == 0
                              ? 1
                              : state.pkmNature!]
                          .map((multiplier) => my.TableCell(
                                content: multiplier == 1
                                    ? "-"
                                    : "x" + multiplier.toString(),
                                mainDecoration: mainDecoration,
                                textColor: textColor,
                              ))
                          .toList()
                    ],
                    mainDecoration: mainDecoration.copyWith(
                        color: Colors.black.withAlpha(60)),
                    textColor: textColor),
                my.TableRow(
                    tableTitle: "Base Stats",
                    children: [
                      ...state.selectedSpecies.baseStats
                          .map((statVal) => my.TableCell(
                                content: statVal.toString(),
                                mainDecoration: mainDecoration,
                                textColor: textColor,
                              ))
                          .toList()
                    ],
                    mainDecoration: mainDecoration.copyWith(
                        color: Colors.black.withAlpha(60)),
                    textColor: textColor),
                if (state.calculationType != CalculationType.Stat)
                  my.TableRow(
                      tableTitle: "Stats",
                      children: [
                        for (var i = 0; i < 6; i++)
                          my.TableCellEditable(
                            value: state.pkmStats[i] == null
                                ? ""
                                : state.pkmStats[i].toString(),
                            mainDecoration: mainDecoration,
                            textColor: textColor,
                            focusNode: getFocusNode(i: i, isStats: true),
                            nextFocusNode: getNextFocusNode(
                                i: i,
                                type: state.calculationType,
                                isStats: true),
                            onChanged: (value) {
                              var newValue = int.tryParse(value);
                              Provider.of<CalculationState>(context,
                                      listen: false)
                                  .setStat(i, newValue);
                            },
                          )
                      ],
                      mainDecoration: mainDecoration.copyWith(
                          color: Colors.black.withAlpha(60)),
                      textColor: textColor),
                if (state.calculationType != CalculationType.IV)
                  my.TableRow(
                      tableTitle: "IVs",
                      children: [
                        for (var i = 0; i < 6; i++)
                          my.TableCellEditable(
                            value: state.pkmIVs[i] == null
                                ? ""
                                : state.pkmIVs[i].toString(),
                            mainDecoration: mainDecoration,
                            textColor: textColor,
                            focusNode: getFocusNode(i: i, isIV: true),
                            nextFocusNode: getNextFocusNode(
                                i: i, type: state.calculationType, isIV: true),
                            onChanged: (value) {
                              var newValue = int.tryParse(value);
                              Provider.of<CalculationState>(context,
                                      listen: false)
                                  .setIV(i, newValue);
                            },
                          )
                      ],
                      mainDecoration: mainDecoration.copyWith(
                          color: Colors.black.withAlpha(60)),
                      textColor: textColor),
                if (state.calculationType != CalculationType.EV)
                  my.TableRow(
                      tableTitle: "EVs",
                      children: [
                        for (var i = 0; i < 6; i++)
                          my.TableCellEditable(
                            value: state.pkmEVs[i] == null
                                ? ""
                                : state.pkmEVs[i].toString(),
                            mainDecoration: mainDecoration,
                            textColor: textColor,
                            focusNode: getFocusNode(i: i, isEv: true),
                            nextFocusNode: getNextFocusNode(
                                i: i, type: state.calculationType, isEv: true),
                            onChanged: (value) {
                              var newValue = int.tryParse(value);
                              Provider.of<CalculationState>(context,
                                      listen: false)
                                  .setEV(i, newValue);
                            },
                          )
                      ],
                      mainDecoration: mainDecoration.copyWith(
                          color: Colors.black.withAlpha(60)),
                      textColor: textColor),
                if (state.calculationType == CalculationType.EV)
                  my.TableRow(
                      tableTitle: "Result EVs",
                      children: [
                        ...state.resultEVs
                            .map((ep) => my.TableCell(
                                  content: ep,
                                  mainDecoration: mainDecoration,
                                  textColor: textColor,
                                ))
                            .toList()
                      ],
                      mainDecoration: mainDecoration.copyWith(
                          color: Colors.black.withAlpha(60)),
                      textColor: textColor),
                if (state.calculationType == CalculationType.IV)
                  my.TableRow(
                      tableTitle: "Result IVs",
                      children: [
                        ...state.resultIVs
                            .map((iv) => my.TableCell(
                                  content: iv,
                                  mainDecoration: mainDecoration,
                                  textColor: textColor,
                                ))
                            .toList()
                      ],
                      mainDecoration: mainDecoration.copyWith(
                          color: Colors.black.withAlpha(60)),
                      textColor: textColor),
                if (state.calculationType == CalculationType.Stat)
                  my.TableRow(
                      tableTitle: "Result Stats",
                      children: [
                        ...state.resultStats
                            .map((stat) => my.TableCell(
                                  content: stat,
                                  mainDecoration: mainDecoration,
                                  textColor: textColor,
                                ))
                            .toList()
                      ],
                      mainDecoration: mainDecoration.copyWith(
                          color: Colors.black.withAlpha(60)),
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
    for (var node in statsFocusNodes) {
      node.dispose();
    }
    for (var node in ivFocusNodes) {
      node.dispose();
    }
    for (var node in evFocusNodes) {
      node.dispose();
    }
    emptyFocusNode.dispose();
    super.dispose();
  }
}
