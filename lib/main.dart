import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_stats_calculator/pages/home_page.dart';
import 'package:pokemon_stats_calculator/state.dart';
import 'package:pokemon_stats_calculator/utils.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import 'data/pokemons.dart';

void main() {
  runApp(const MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return ChangeNotifierProvider(
      create: (context) => CalculationState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
        scrollBehavior: AppScrollBehavior(),
        home: const HomePage(),
      ),
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String message = 'nothing';
  List<List<String>> dataToShow = [];
  List<List<String>> dataToShow2 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          OutlinedButton(
            child: const Text("Test"),
            onPressed: () {
              var species = getSpeciesByNumber("612");
              var species2 = getSpeciesByNumber("6");
              try {
                dataToShow.clear();
                for (var i = 0; i <= 100; i++) {
                  dataToShow.add(getStats(
                    species.id,
                    i,
                    9,
                    [31, 31, 31, 31, 31, 31],
                    [0, 0, 0, 0, 0, 0],
                  ));
                  dataToShow2.clear();
                  for (var i = 0; i <= 100; i++) {
                    dataToShow2.add(getStats(
                      species2.id,
                      i,
                      9,
                      [31, 31, 31, 31, 31, 31],
                      [0, 0, 0, 0, 0, 0],
                    ));
                  }
                }
                setState(() {});
              } catch (e) {
                setState(() {
                  message = e.toString();
                });
              }
            },
          ),
          Container(
            width: 550,
            height: 400,
            color: Colors.amber,
            child: Stack(children: [
              for (var j = 0; j < 6; j++)
                for (var i = 0; i < dataToShow.length; i++)
                  Positioned(
                    left: i.toDouble() * 5,
                    bottom: double.tryParse(dataToShow[i][j]) ?? 0,
                    child: Icon(
                      Icons.circle,
                      color: [
                        Colors.yellow,
                        Colors.blue,
                        Colors.red,
                        Colors.green,
                        Colors.brown,
                        Colors.purple,
                      ][j],
                      size: 6,
                    ),
                  ),
              for (var j = 0; j < 6; j++)
                for (var i = 0; i < dataToShow2.length; i++)
                  Positioned(
                    left: i.toDouble() * 5,
                    bottom: double.tryParse(dataToShow2[i][j]) ?? 0,
                    child: Icon(
                      Icons.crop_square,
                      color: [
                        Colors.yellow,
                        Colors.blue,
                        Colors.red,
                        Colors.green,
                        Colors.brown,
                        Colors.purple,
                      ][j],
                      size: 6,
                    ),
                  ),
            ]),
          )
        ],
      )),
    );
  }
}
