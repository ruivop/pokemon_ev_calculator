import 'data/pokemons.dart';
import 'data/stats.dart';

List<int> getEVs(String pkmNum, int pkmLvl, int pkmNature, List<int> pkmStats,
    List<int> pkmIvs) {
  List<int> evs = [];
  for (int statIndex = 0; statIndex < 6; statIndex++) {
    int ev = 0;
    for (int testEvIndex = 0; testEvIndex < 256; testEvIndex++) {
      if (calcStat(pkmNum, statIndex, pkmIvs[statIndex], testEvIndex, pkmLvl,
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

int calcStat(String species, int pstat, int stativ, int statev, int pokelvl,
    int nature) {
  //Calculates Pokemon stats
  int basestat = getBase(species, pstat);
  int result = 0;
  if (pstat == 0) {
    //HP uses a different formula
    result =
        ((((basestat * 2 + (stativ / 1) + (statev / 4).floor()) * pokelvl) /
                    100)
                .floor()) +
            pokelvl +
            10;
    if (species == "292") {
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
