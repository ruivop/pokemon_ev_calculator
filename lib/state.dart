import 'package:flutter/cupertino.dart';
import 'package:pokemon_stats_calculator/utils.dart';

import 'data/pokemons.dart';
import 'generated/l10n.dart';

class CError {
  String Function(BuildContext context) message;

  CError(this.message);
}

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

  late List<CError> errors;

  bool isShowingStatsByTable = false;

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
    isShowingStatsByTable = false;
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

  setIsShowingStatsByTable(bool newValue) {
    isShowingStatsByTable = newValue;
    _calculate();
  }

  Future<void> dummyAsync() async {
    await Future.delayed(const Duration(milliseconds: 1));
  }

  _calculate() async {
    if (calculationType == null) return;
    await dummyAsync();
    if (calculationType == CalculationType.ev) {
      _calculateEvs();
    } else if (calculationType == CalculationType.iv) {
      _calculateIvs();
    } else {
      _calculateStats();
    }
  }

  _calculateEvs() {
    errors.clear();
    if (pkmNature == null || pkmNature == 0) {
      errors.add(CError((c) => S.of(c).validationNature));
    }
    if (pkmStats.any((stat) => stat == null)) {
      errors.add(CError((c) => S.of(c).validationStats));
    }
    if (pkmIVs.any((iv) => iv == null)) {
      errors.add(CError((c) => S.of(c).validationIVs));
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
      errors.add(CError((c) => S.of(c).validationNature));
    }
    if (pkmStats.any((stat) => stat == null)) {
      errors.add(CError((c) => S.of(c).validationStats));
    }
    if (pkmEVs.any((ev) => ev == null)) {
      errors.add(CError((c) => S.of(c).validationEVs));
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
      errors.add(CError((c) => S.of(c).validationNature));
    }
    if (pkmIVs.any((iv) => iv == null)) {
      errors.add(CError((c) => S.of(c).validationIVs));
    }
    if (pkmEVs.any((ev) => ev == null)) {
      errors.add(CError((c) => S.of(c).validationEVs));
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

  List<CalculatedStats>? calculateStatsBy() {
    int natureToUse = pkmNature == null || pkmNature == 0 ? 1 : pkmNature!;

    if (calculationType == CalculationType.stat) {
      return calcStatsByLevel(
          selectedSpecies.id,
          pkmIVs.map((e) => e ?? 0).toList(),
          pkmEVs.map((e) => e ?? 0).toList(),
          natureToUse);
    } else if (calculationType == CalculationType.iv) {
      return calcStatsByIv(selectedSpecies.id,
          pkmEVs.map((e) => e ?? 0).toList(), pkmLvl, natureToUse);
    } else if (calculationType == CalculationType.ev) {
      return calcStatsByEv(selectedSpecies.id,
          pkmIVs.map((e) => e ?? 0).toList(), pkmLvl, natureToUse);
    } else {
      return null;
    }
  }
}

enum CalculationType {
  iv,
  ev,
  stat,
}
