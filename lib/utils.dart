import 'data/pokemons.dart';
import 'data/stats.dart';

List<String> getStats(int pkmId, int pkmLvl, int pkmNature, List<int?> pkmIVs,
    List<int?> pkmEVs) {
  List<String> evs = [];
  for (int statIndex = 0; statIndex < 6; statIndex++) {
    String stat = "";
    if (pkmIVs[statIndex] != null && pkmEVs[statIndex] != null) {
      stat = calcStat(
        pkmId,
        statIndex,
        pkmIVs[statIndex]!,
        pkmEVs[statIndex]!,
        pkmLvl,
        pkmNature,
      ).toString();
    }
    evs.add(stat);
  }
  return evs;
}

List<String> getEVs(int pkmId, int pkmLvl, int pkmNature, List<int?> pkmStats,
    List<int?> pkmIvs) {
  List<String> evs = [];
  for (int statIndex = 0; statIndex < 6; statIndex++) {
    String ev = "";
    if (pkmStats[statIndex] != null && pkmIvs[statIndex] != null) {
      for (int testEvIndex = 0; testEvIndex < 256; testEvIndex++) {
        if (calcStat(pkmId, statIndex, pkmIvs[statIndex]!, testEvIndex, pkmLvl,
                pkmNature) ==
            pkmStats[statIndex]) {
          ev = testEvIndex.toString();
          break;
        }
      }
      if (ev.isEmpty) {
        ev = "?";
      }
    }
    evs.add(ev);
  }
  return evs;
}

int calcStat(
    int speciesId, int pstat, int stativ, int statev, int pokelvl, int nature) {
  //Calculates Pokemon stats
  int basestat = getBase(speciesId, pstat);
  int result = 0;
  if (pstat == 0) {
    //HP uses a different formula
    result =
        ((((basestat * 2 + (stativ / 1) + (statev / 4).floor()) * pokelvl) /
                    100)
                .floor()) +
            pokelvl +
            10;
    if (allSpecies[speciesId]!.number == "292") {
      return 1;
    } //Shedinja Case
  } else {
    double bonus = natures[nature][(pstat - 1)];
    result =
        (((((basestat * 2 + (stativ / 1) + (statev / 4).floor()) * pokelvl) /
                            100)
                        .floor() +
                    5) *
                bonus)
            .floor();
  }
  return result;
}

List<String> validateStats(int speciesId, int pkmLvl, int pkmNature,
    List<int?> pkmStats, List<int?> pkmEvs) {
  List<String> errors = [];
  for (var i = 0; i < 6; i++) {
    if (pkmStats[i] == null) {
      continue;
    }
    var min = calcStat(speciesId, i, 0, pkmEvs[i] ?? 0, pkmLvl, pkmNature);
    var max = calcStat(speciesId, i, 31, pkmEvs[i] ?? 255, pkmLvl, pkmNature);
    if (pkmStats[i]! < min || pkmStats[i]! > max) {
      errors.add("Invalid " +
          statNames[i] +
          " stat. Must be between " +
          min.toString() +
          " and " +
          max.toString());
    }
  }
  return errors;
}

List<List<int>> getIVs(int speciesId, int pkmLvl, int pkmNature,
    List<int?> pkmStats, List<int?> pkmEvs) {
  List<List<int>> ivs = [];
  //Calculate IVs
  for (var i = 0; i < 6; i++) {
    if (pkmStats[i] == null || pkmEvs[i] == null) {
      ivs.add([]);
      continue;
    }
    var result =
        calcStativ(speciesId, i, pkmStats[i]!, pkmEvs[i]!, pkmLvl, pkmNature);
    ivs.add(result);
  }
  return ivs;
}

class CalculatedStats {
  final List<String> stats;
  final String label;

  const CalculatedStats(this.stats, this.label);
}

List<CalculatedStats> calcStatsByIv(
    int speciesId, List<int> evs, int level, int natureIndex) {
  List<CalculatedStats> statsByIv = [];
  for (var i = 0; i < 32; i++) {
    var stats = <String>[];
    for (var statIndex = 0; statIndex < 6; statIndex++) {
      //Shedinja
      if (statIndex == 0 && allSpecies[speciesId]!.number == "292") {
        stats.add(1.toString());
      } else {
        stats.add(calcStat(
                speciesId, statIndex, i, evs[statIndex], level, natureIndex)
            .toString());
      }
    }
    statsByIv.add(CalculatedStats(stats, i.toString()));
  }

  return statsByIv;
}

List<CalculatedStats> calcStatsByEv(
    int speciesId, List<int> ivs, int level, int natureIndex) {
  List<CalculatedStats> statsByEv = [];
  for (var i = 0; i < 256; i += 4) {
    var stats = <String>[];
    for (var statIndex = 0; statIndex < 6; statIndex++) {
      //Shedinja
      if (statIndex == 0 && allSpecies[speciesId]!.number == "292") {
        stats.add(1.toString());
      } else {
        stats.add(calcStat(
                speciesId, statIndex, ivs[statIndex], i, level, natureIndex)
            .toString());
      }
    }
    statsByEv.add(CalculatedStats(stats, i.toString()));
  }

  return statsByEv;
}

List<CalculatedStats> calcStatsByLevel(
    int speciesId, List<int> ivs, List<int> evs, int natureIndex) {
  List<CalculatedStats> statsByLevel = [];
  for (var i = 1; i <= 100; i++) {
    var stats = <String>[];
    for (var statIndex = 0; statIndex < 6; statIndex++) {
      //Shedinja
      if (statIndex == 0 && allSpecies[speciesId]!.number == "292") {
        stats.add(1.toString());
      } else {
        stats.add(calcStat(speciesId, statIndex, ivs[statIndex], evs[statIndex],
                i, natureIndex)
            .toString());
      }
    }
    statsByLevel.add(CalculatedStats(stats, i.toString()));
  }

  return statsByLevel;
}

List<int> calcStativ(int speciesId, int statIndex, int statValue, int ev,
    int level, int natureIndex) {
  List<int> ivs = [];

  //Shedinja
  if (statIndex == 0 && allSpecies[speciesId]!.number == "292") {
    return [];
  }
  for (var i = 0; i < 32; i++) {
    if (calcStat(speciesId, statIndex, i, ev, level, natureIndex) ==
        statValue) {
      ivs.add(i);
    }
  }
  return ivs;
}

List<String> validateIVs(List<int?> ivs) {
  List<String> errors = [];
  for (var i = 0; i < 6; i++) {
    if (ivs[i] == null) {
      continue;
    }
    if (ivs[i]! < 0 || ivs[i]! > 31) {
      errors.add("Invalid " + statNames[i] + " IV. Must be between 0 and 31");
    }
  }
  return errors;
}

List<String> validateEVs(List<int?> evs) {
  List<String> errors = [];
  int sum = 0;
  for (var i = 0; i < 6; i++) {
    if (evs[i] == null) {
      continue;
    }
    if (evs[i]! < 0 || evs[i]! > 255) {
      errors.add("Invalid " + statNames[i] + " EV. Must be between 0 and 255");
    }
    sum += evs[i]!;
  }
  if (sum > 510) {
    errors.add("Sum of all EVs must be less than 510");
  }
  return errors;
}

class MException implements Exception {
  String message;
  MException(this.message) : super();

  @override
  String toString() {
    return message;
  }
}
