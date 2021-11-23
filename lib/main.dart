import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_ev_calculator/reusable/card.dart';
import 'package:pokemon_ev_calculator/state.dart';
import 'package:pokemon_ev_calculator/utils.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'cards/level_selector.dart';
import 'cards/nature_selector.dart';
import 'cards/stats_selector.dart';
import 'header.dart';

void main() {
  runApp(const MyApp());
}
/*
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      //scrollBehavior: AppScrollBehavior(),
      home: const MainLayout(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        child: Text("Calculate"),
        onPressed: () {
          //test
          var pkmNum = "612";
          var pkmNature = 9; //timid
          var pkmLvl = 70;
          var pkmStats = [208, 203, 147, 116, 129, 179];
          var pkmIvs = [27, 11, 15, 31, 31, 28];

          print(getEVs(pkmNum, pkmLvl, pkmNature, pkmStats, pkmIvs));
        },
      ),
    );
  }
}

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => CalculationState(),
        child: Consumer<CalculationState>(
          builder: (context, state, child) {
            return Container(
              color: Colors.black,
              child: SafeArea(
                child: Container(
                  child: child,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.lerp(state.selectedPokemon.getColorType1(),
                            Colors.black, 0.2)!,
                        Color.lerp(state.selectedPokemon.getColorType1(),
                            Colors.black, 0.5)!,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: CustomScrollView(
            slivers: [
              const Header(),
              SliverClip(
                child: MultiSliver(children: [
                  const LevelSelector(),
                  const NatureSelector(),
                  const StatsSelector(),
                  for (var i = 0; i < 10; i++)
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
                    ),
                ]),
              ),
              /*const SliverFillRemaining(
                    child: Home(),
                  ),*/
            ],
          ),
        ),
      ),
    );
  }
}
