import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_ev_calculator/cards/level_selector.dart';
import 'package:pokemon_ev_calculator/cards/nature_selector.dart';
import 'package:pokemon_ev_calculator/cards/problems_card.dart';
import 'package:pokemon_ev_calculator/cards/stats_selector.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../header.dart';
import '../state.dart';

class CalculateEVPage extends StatelessWidget {
  const CalculateEVPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => CalculationState(),
          child: Consumer<CalculationState>(
            builder: (context, state, child) {
              return Container(
                color: Colors.black,
                child: SafeArea(
                  child: Container(
                    child: CustomScrollView(
                      slivers: [
                        Header(
                          selectedSpecies: state.selectedSpecies,
                          onSpeciesChange: (species) {
                            state.setNewSpecies(species);
                          },
                          onClear: () {
                            state.initializeValues();
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
                            const StatsSelector(),
                            ProblemsCard(errors: state.errors),
                            /*for (var i = 0; i < 10; i++)
                      SelectionCard(
                        header: Row(
                          children: [
                            Icon(
                              CupertinoIcons.slider_horizontal_below_rectangle,
                              color: Colors.white.withAlpha(150),
                              size: 16,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "HOURLY FORECAST",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(150),
                                ),
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                        ),
                      ),*/
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
      ),
    );
  }
}
