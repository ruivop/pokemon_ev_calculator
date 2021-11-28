import 'data/pokemons.dart';
import 'data/stats.dart';

List<int> getEVs(int pkmId, int pkmLvl, int pkmNature, List<int> pkmStats,
    List<int> pkmIvs) {
  List<int> evs = [];
  for (int statIndex = 0; statIndex < 6; statIndex++) {
    int ev = 0;
    for (int testEvIndex = 0; testEvIndex < 256; testEvIndex++) {
      if (calcStat(pkmId, statIndex, pkmIvs[statIndex], testEvIndex, pkmLvl,
              pkmNature) ==
          pkmStats[statIndex]) {
        ev = testEvIndex;
        break;
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

List<List<int>> getIVs(int speciesId, int pkmLvl, int pkmNature,
    List<int> pkmStats, List<int> pkmEvs) {
  //validate IVs
  for (var i = 0; i < 6; i++) {
    var min = calcStat(speciesId, i, 0, pkmEvs[i], pkmLvl, pkmNature);
    var max = calcStat(speciesId, i, 31, pkmEvs[i], pkmLvl, pkmNature);
    if (pkmStats[i] < min || pkmStats[i] > max) {
      throw MException("Invalid " +
          statNames[i] +
          " stat. Must be between " +
          min.toString() +
          " and " +
          max.toString());
    }
  }

  List<List<int>> ivs = [];
  //Calculate IVs
  for (var i = 0; i < 6; i++) {
    var result =
        calcStativ(speciesId, i, pkmStats[i], pkmEvs[i], pkmLvl, pkmNature);
    ivs.add(result);
  }
  return ivs;
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

class MException implements Exception {
  String message;
  MException(this.message) : super();

  @override
  String toString() {
    return message;
  }
}
