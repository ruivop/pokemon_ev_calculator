import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_ev_calculator/reusable/card.dart';

class StatsSelector extends StatelessWidget {
  const StatsSelector({Key? key}) : super(key: key);

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
                for (var i = 0; i < 7; i++)
                  Expanded(
                      child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border(
                        top: mainBorderSide,
                        bottom: mainBorderSide,
                        left: mainBorderSide,
                      ),
                    ),
                    child: Center(
                        child: Text("Atk",
                            style: TextStyle(
                              color: Colors.white.withAlpha(150),
                            ))),
                  ))
              ],
            ),
          )
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            right: mainBorderSide,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < 6; i++)
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        decoration: mainDecoration,
                        child: Center(
                          child: Text(
                            "Nature Efect",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withAlpha(150),
                            ),
                          ),
                        ),
                      ),
                    ),
                    for (var i = 0; i < 6; i++)
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          decoration: mainDecoration,
                          child: Center(
                            child: Text(
                              "100",
                              style: TextStyle(
                                color: Colors.white.withAlpha(150),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
