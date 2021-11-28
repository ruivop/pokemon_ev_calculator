import 'package:flutter/cupertino.dart';
import 'package:pokemon_ev_calculator/utils.dart';

import 'data/pokemons.dart';

class CalculationState extends ChangeNotifier {
  CalculationType? calculationType;

  late Species selectedSpecies;
  late int? pkmNature;
  late int pkmLvl;
  late List<int?> pkmStats;
  late List<int?> pkmIVs;
  late List<int?> pkmEVs;

  late List<String> resultIVs;
  late List<String> resultEVs;

  late List<String> errors;

  CalculationState() {
    initializeValues();
  }

  initializeValues() {
    selectedSpecies = allSpecies.entries.first.value;
    pkmNature = null;
    pkmLvl = 50;
    pkmStats = [null, null, null, null, null, null];
    pkmIVs = [null, null, null, null, null, null];
    resultIVs = ["", "", "", "", "", ""];
    resultEVs = ["", "", "", "", "", ""];
    errors = [];
    _calculate();
  }

  setCalculationType(CalculationType type) {
    calculationType = type;
    _calculate();
  }

  setNewNature(int newNature) {
    pkmNature = newNature;
    _calculate();
  }

  setNewLevel(int newLevel) {
    if (newLevel == pkmLvl) return;
    pkmLvl = newLevel;
    _calculate();
  }

  setNewSpecies(Species newPokemon) {
    selectedSpecies = newPokemon;
    _calculate();
  }

  setStat(int statIndex, int? newValue) {
    pkmStats[statIndex] = newValue;
    _calculate();
  }

  setIV(int ivIndex, int? newValue) {
    pkmIVs[ivIndex] = newValue;
    _calculate();
  }

  _calculate() {
    if (calculationType == null) return;
    if (calculationType == CalculationType.EV) {
      _calculateEvs();
    } else if (calculationType == CalculationType.IV) {
      _calculateIvs();
    } else {
      _calculateStats();
    }
  }

  _calculateEvs() {
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

  _calculateIvs() {}

  _calculateStats() {}
}

enum CalculationType {
  IV,
  EV,
  Stat,
}
