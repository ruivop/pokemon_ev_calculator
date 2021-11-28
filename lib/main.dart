import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_ev_calculator/pages/home_page.dart';
import 'package:pokemon_ev_calculator/state.dart';
import 'package:pokemon_ev_calculator/utils.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import 'data/pokemons.dart';

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
    Wakelock.enable();
    return ChangeNotifierProvider(
      create: (context) => CalculationState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
        //scrollBehavior: AppScrollBehavior(),
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
              try {
                var evs = getIVs(
                  species.id,
                  70,
                  9,
                  [208, 203, 147, 110, 124, 178],
                  [16, 44, 32, 32, 28, 16],
                );
                setState(() {
                  message = evs.toString();
                });
              } catch (e) {
                setState(() {
                  message = e.toString();
                });
              }
            },
          ),
        ],
      )),
    );
  }
}
