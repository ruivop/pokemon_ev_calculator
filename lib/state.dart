import 'package:flutter/cupertino.dart';
import 'package:pokemon_ev_calculator/utils.dart';

import 'data/pokemons.dart';

class CalculationState extends ChangeNotifier {
  late Species selectedSpecies;
  int? pkmNature;
  int pkmLvl = 50;
  List<int?> pkmStats = [null, null, null, null, null, null];
  List<int?> pkmIVs = [null, null, null, null, null, null];

  List<String> resultEVs = ["", "", "", "", "", ""];

  List<String> errors = [];

  CalculationState() {
    initializeValues();
  }

  initializeValues() {
    selectedSpecies = allSpecies.entries.first.value;
    pkmNature = null;
    pkmLvl = 50;
    pkmStats = [null, null, null, null, null, null];
    pkmIVs = [null, null, null, null, null, null];
    resultEVs = ["", "", "", "", "", ""];
    calculateEVs();
  }

  setNewNature(int newNature) {
    pkmNature = newNature;
    calculateEVs();
  }

  setNewLevel(int newLevel) {
    if (newLevel == pkmLvl) return;
    pkmLvl = newLevel;
    calculateEVs();
  }

  setNewSpecies(Species newPokemon) {
    selectedSpecies = newPokemon;
    calculateEVs();
  }

  setStat(int statIndex, int? newValue) {
    pkmStats[statIndex] = newValue;
    calculateEVs();
  }

  setIV(int ivIndex, int? newValue) {
    pkmIVs[ivIndex] = newValue;
    calculateEVs();
  }

  calculateEVs() {
    errors.clear();
    if (pkmNature == null || pkmNature == 0) {
      errors.add("Please select a nature.");
    }
    if (pkmStats.any((stat) => stat == null)) {
      errors.add("Please select all stats.");
    }
    if (pkmIVs.any((iv) => iv == null)) {
      errors.add("Please select all IVs.");
    }

    if (errors.isEmpty) {
      resultEVs = getEVs(
        selectedSpecies.id,
        pkmLvl,
        pkmNature!,
        pkmStats.map((e) => e ?? 0).toList(),
        pkmIVs.map((e) => e ?? 0).toList(),
      ).map((e) => e.toString()).toList();
    } else {
      resultEVs = ["", "", "", "", "", ""];
    }
    notifyListeners();
  }
}
