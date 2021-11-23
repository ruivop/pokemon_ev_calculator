import 'package:flutter/cupertino.dart';

import 'data/pokemons.dart';

class CalculationState extends ChangeNotifier {
  late Species selectedPokemon;
  int? pkmNature;
  int? pkmLvl;
  List<int?> pkmStats = [null, null, null, null, null, null];
  List<int?> pkmIvs = [null, null, null, null, null, null];

  CalculationState() {
    selectedPokemon = allSpecies["4"] ??
        Species(
            "-1", "Error", [0, 0, 0, 0, 0, 0], 0, 0, 0, 0, [0, 0, 0, 0, 0, 0]);
  }

  setNewNature(int newNature) {
    pkmNature = newNature;
    notifyListeners();
  }

  setNewPokeon(Species newPokemon) {
    selectedPokemon = newPokemon;
    notifyListeners();
  }
}
