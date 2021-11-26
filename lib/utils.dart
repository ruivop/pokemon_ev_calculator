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
