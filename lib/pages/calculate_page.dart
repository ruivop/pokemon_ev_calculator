import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_ev_calculator/cards/level_selector.dart';
import 'package:pokemon_ev_calculator/cards/nature_selector.dart';
import 'package:pokemon_ev_calculator/cards/problems_card.dart';
import 'package:pokemon_ev_calculator/cards/ev_table_selector.dart';
import 'package:pokemon_ev_calculator/cards/stats_table.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../header.dart';
import '../state.dart';

var problemsCardKey = GlobalKey();

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Consumer<CalculationState>(
          builder: (context, state, child) {
            return Container(
              color: Colors.black,
              child: SafeArea(
                child: Container(
                  child: CustomScrollView(
                    controller: controller,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    slivers: [
                      Header(
                        selectedSpecies: state.selectedSpecies,
                        onSpeciesChange: (species) {
                          state.setNewSpecies(species);
                        },
                        onClear: () {
                          state.initializeValues();
                        },
                        errorCount: state.errors.length,
                        onProblemsBadgeClick: () {
                          if (problemsCardKey.currentContext != null) {
                            problemsCardKey.currentContext!
                                .findRenderObject()!
                                .showOnScreen(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                          }
                        },
                      ),
                      SliverClip(
                        child: MultiSliver(children: [
                          LevelSelector(
                              level: state.pkmLvl,
                              onLevelChanged: (level) {
                                state.setNewLevel(level);
                              }),
                          NatureSelector(
                              natureIndex: state.pkmNature,
                              selectedPokemon: state.selectedSpecies,
                              onNatureChanged: (nature) {
                                state.setNewNature(nature);
                              }),
                          const EVTableSelector(),
                          ProblemsCard(
                            key: problemsCardKey,
                            errors: state.errors,
                          ),
                          StatsTable(
                            statsToShow: state.calculateStatsBy(),
                            actualStats:
                                state.calculationType == CalculationType.Stat
                                    ? state.resultStats
                                        .map((e) => int.tryParse(e))
                                        .toList()
                                    : state.pkmStats,
                            calculationType: state.calculationType,
                          ),
                        ]),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.lerp(state.selectedSpecies.getColorType1(),
                            Colors.black, 0.2)!,
                        Color.lerp(state.selectedSpecies.getColorType1(),
                            Colors.black, 0.5)!,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
