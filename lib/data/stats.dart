//ATK/DEF/SP.ATK/SP.DEF/SPD / Bashful 1, Docile 2, Hardy 3, Serious 4, Quirky 5, Bold 6, Modest 7, Calm 8, Timid 9, Lonely 10, Mild 11, Gentle 12, Hasty 13, Adamant 14, Impish 15, Careful 16, Jolly 17, Naughty 18, Lax 19, Rash 20, Naive 21, Brave 22, Relaxed 23, Quiet 24, Sassy 25
import 'package:flutter/material.dart';
import 'package:pokemon_stats_calculator/generated/l10n.dart';

List<List<double>> natures = [
  [],
  [1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1],
  [0.9, 1.1, 1, 1, 1],
  [0.9, 1, 1.1, 1, 1],
  [0.9, 1, 1, 1.1, 1],
  [0.9, 1, 1, 1, 1.1],
  [1.1, 0.9, 1, 1, 1],
  [1, 0.9, 1.1, 1, 1],
  [1, 0.9, 1, 1.1, 1],
  [1, 0.9, 1, 1, 1.1],
  [1.1, 1, 0.9, 1, 1],
  [1, 1.1, 0.9, 1, 1],
  [1, 1, 0.9, 1.1, 1],
  [1, 1, 0.9, 1, 1.1],
  [1.1, 1, 1, 0.9, 1],
  [1, 1.1, 1, 0.9, 1],
  [1, 1, 1.1, 0.9, 1],
  [1, 1, 1, 0.9, 1.1],
  [1.1, 1, 1, 1, 0.9],
  [1, 1.1, 1, 1, 0.9],
  [1, 1, 1.1, 1, 0.9],
  [1, 1, 1, 1.1, 0.9]
];

List<NatureName>? _calculatedNatureNames;
List<NatureName> calculateNames(BuildContext context) {
  _calculatedNatureNames ??= [
    NatureName("", 0),
    NatureName(S.of(context).natureBashful, 1),
    NatureName(S.of(context).natureDocile, 2),
    NatureName(S.of(context).natureHardy, 3),
    NatureName(S.of(context).natureSerious, 4),
    NatureName(S.of(context).natureQuirky, 5),
    NatureName(S.of(context).natureBold, 6),
    NatureName(S.of(context).natureModest, 7),
    NatureName(S.of(context).natureCalm, 8),
    NatureName(S.of(context).natureTimid, 9),
    NatureName(S.of(context).natureLonely, 10),
    NatureName(S.of(context).natureMild, 11),
    NatureName(S.of(context).natureGentle, 12),
    NatureName(S.of(context).natureHasty, 13),
    NatureName(S.of(context).natureAdamant, 14),
    NatureName(S.of(context).natureImpish, 15),
    NatureName(S.of(context).natureCareful, 16),
    NatureName(S.of(context).natureJolly, 17),
    NatureName(S.of(context).natureNaughty, 18),
    NatureName(S.of(context).natureLax, 19),
    NatureName(S.of(context).natureRash, 20),
    NatureName(S.of(context).natureNaive, 21),
    NatureName(S.of(context).natureBrave, 22),
    NatureName(S.of(context).natureRelaxed, 23),
    NatureName(S.of(context).natureQuiet, 24),
    NatureName(S.of(context).natureSassy, 25),
  ]..sort((a, b) => a.name.compareTo(b.name));
  return _calculatedNatureNames!;
}

List<NatureName> get natureNames {
  return _calculatedNatureNames!;
}

class NatureName {
  String name;
  int id;
  NatureName(this.name, this.id);
}

String getNatureNameById(int id) {
  return natureNames.firstWhere((element) => element.id == id).name;
}

List<double> ivr = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31
];

List<String>? _computedStatNames;
List<String> computeStatNames(BuildContext context) {
  _computedStatNames ??= [
    S.of(context).statFullHP,
    S.of(context).statFullAtk,
    S.of(context).statFullDef,
    S.of(context).statFullSpA,
    S.of(context).statFullSpD,
    S.of(context).statFullSpd,
  ];
  return _computedStatNames!;
}

List<String> get statNames {
  return _computedStatNames!;
}

List<Color> typesColors = const [
  Color(0xFFC6C6A7), //'Normal',
  Color(0xFFD67873), //'Fighting',
  Color(0xFFC6B7F5), //'Flying',
  Color(0xFFC183C1), //'Poison',
  Color(0xFFEBD69D), //'Ground',
  Color(0xFFD1C17D), //'Rock',
  Color(0xFFC6D16E), //'Bug',
  Color(0xFFA292BC), //'Ghost',
  Color(0xFFD1D1E0), //'Steel',
  Color(0xFFC6C6A7), //'???',
  Color(0xFFF5AC78), //'Fire',
  Color(0xFF9DB7F5), //'Water',
  Color(0xFFA7DB8D), //'Grass',
  Color(0xFFFAE078), //'Electric',
  Color(0xFFFA92B2), //'Psychic',
  Color(0xFFBCE6E6), //'Ice',
  Color(0xFFA27DFA), //'Dragon',
  Color(0xFFA29288), //'Dark',
  Color(0xFFF4BDC9), //'Fairy'
];
