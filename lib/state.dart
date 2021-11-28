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
  late List<String> resultStats;

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
    pkmEVs = [0, 0, 0, 0, 0, 0];
    resultIVs = ["", "", "", "", "", ""];
    resultEVs = ["", "", "", "", "", ""];
    resultStats = ["", "", "", "", "", ""];
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

  setEV(int ivIndex, int? newValue) {
    pkmEVs[ivIndex] = newValue;
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

    int natureToUse = pkmNature == null || pkmNature == 0 ? 1 : pkmNature!;

    resultEVs = getEVs(
      selectedSpecies.id,
      pkmLvl,
      natureToUse,
      pkmStats,
      pkmIVs,
    );

    errors.addAll(validateStats(
      selectedSpecies.id,
      pkmLvl,
      natureToUse,
      pkmStats,
      resultEVs.map((e) => int.tryParse(e)).toList(),
    ));
    errors.addAll(validateIVs(pkmIVs));
    errors.addAll(validateEVs(resultEVs.map((e) => int.tryParse(e)).toList()));

    notifyListeners();
  }

  _calculateIvs() {
    errors.clear();
    if (pkmNature == null || pkmNature == 0) {
      errors.add("Please select a nature.");
    }
    if (pkmStats.any((stat) => stat == null)) {
      errors.add("Please select all stats.");
    }
    if (pkmEVs.any((ev) => ev == null)) {
      errors.add("Please select all EVs.");
    }

    int natureToUse = pkmNature == null || pkmNature == 0 ? 1 : pkmNature!;

    errors.addAll(validateStats(
      selectedSpecies.id,
      pkmLvl,
      natureToUse,
      pkmStats,
      pkmEVs,
    ));
    errors.addAll(validateEVs(pkmEVs));

    resultIVs = getIVs(
      selectedSpecies.id,
      pkmLvl,
      natureToUse,
      pkmStats,
      pkmEVs,
    ).map((e) => e.join(",\n")).toList();
    notifyListeners();
  }

  _calculateStats() {
    errors.clear();
    if (pkmNature == null || pkmNature == 0) {
      errors.add("Please select a nature.");
    }
    if (pkmIVs.any((iv) => iv == null)) {
      errors.add("Please select all IVs.");
    }
    if (pkmEVs.any((ev) => ev == null)) {
      errors.add("Please select all EVs.");
    }

    int natureToUse = pkmNature == null || pkmNature == 0 ? 1 : pkmNature!;

    errors.addAll(validateIVs(pkmIVs));
    errors.addAll(validateEVs(pkmEVs));

    resultStats = getStats(
      selectedSpecies.id,
      pkmLvl,
      natureToUse,
      pkmIVs,
      pkmEVs,
    );
    notifyListeners();
  }
}

enum CalculationType {
  IV,
  EV,
  Stat,
}
