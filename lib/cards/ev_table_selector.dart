import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_ev_calculator/cards/table_card_elements.dart' as my;
import 'package:pokemon_ev_calculator/data/stats.dart';
import 'package:pokemon_ev_calculator/reusable/card.dart';
import 'package:provider/provider.dart';

import '../state.dart';

class EVTableSelector extends StatefulWidget {
  const EVTableSelector({Key? key}) : super(key: key);

  @override
  State<EVTableSelector> createState() => _EVTableSelectorState();
}

class _EVTableSelectorState extends State<EVTableSelector> {
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
                          child: my.TableHeader(
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
                    mainDecoration: mainDecoration,
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
                    mainDecoration: mainDecoration,
                    textColor: textColor),
                my.TableRow(
                    tableTitle: "Stats",
                    children: [
                      for (var i = 0; i < 6; i++)
                        my.TableCellEditable(
                          initialValue: state.pkmStats[i] == null
                              ? ""
                              : state.pkmStats[i].toString(),
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
                my.TableRow(
                    tableTitle: "IVs",
                    children: [
                      for (var i = 6; i < 12; i++)
                        my.TableCellEditable(
                          initialValue: state.pkmIVs[i - 6] == null
                              ? ""
                              : state.pkmIVs[i - 6].toString(),
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
