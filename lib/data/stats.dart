//ATK/DEF/SP.ATK/SP.DEF/SPD / Bashful 1, Docile 2, Hardy 3, Serious 4, Quirky 5, Bold 6, Modest 7, Calm 8, Timid 9, Lonely 10, Mild 11, Gentle 12, Hasty 13, Adamant 14, Impish 15, Careful 16, Jolly 17, Naughty 18, Lax 19, Rash 20, Naive 21, Brave 22, Relaxed 23, Quiet 24, Sassy 25
import 'package:flutter/material.dart';

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
/*        natures[-1] = [1, 1, 1, 1, 1]; //neutral
        natures['max'] = [1.1, 1.1, 1.1, 1.1, 1.1]; //all max
        natures['min'] = [0.9, 0.9, 0.9, 0.9, 0.9]; //all max
*/
List<NatureName> natureNames = [
  NatureName("", 0),
  NatureName("Bashful", 1),
  NatureName("Docile", 2),
  NatureName("Hardy", 3),
  NatureName("Serious", 4),
  NatureName("Quirky", 5),
  NatureName("Bold", 6),
  NatureName("Modest", 7),
  NatureName("Calm", 8),
  NatureName("Timid", 9),
  NatureName("Lonely", 10),
  NatureName("Mild", 11),
  NatureName("Gentle", 12),
  NatureName("Hasty", 13),
  NatureName("Adamant", 14),
  NatureName("Impish", 15),
  NatureName("Careful", 16),
  NatureName("Jolly", 17),
  NatureName("Naughty", 18),
  NatureName("Lax", 19),
  NatureName("Rash", 20),
  NatureName("Naive", 21),
  NatureName("Brave", 22),
  NatureName("Relaxed", 23),
  NatureName("Quiet", 24),
  NatureName("Sassy", 25)
]..sort((a, b) => a.name.compareTo(b.name));

class NatureName {
  String name;
  int id;
  NatureName(this.name, this.id);
}

String getNatureNameById(int id) {
  return natureNames.firstWhere((element) => element.id == id).name;
}

//Type affinity no fg fl po gu ro bu gh st ?? fi wa gs el ps ic dr da
List<List<double>> damage = [
  [1, 1, 1, 1, 1, 0.5, 1, 0, 0.5, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  [2, 1, 0.5, 0.5, 1, 2, 0.5, 0, 2, 1, 1, 1, 1, 1, 0.5, 2, 1, 2],
  [1, 2, 1, 1, 1, 0.5, 2, 1, 0.5, 1, 1, 1, 2, 0.5, 1, 1, 1, 1],
  [1, 1, 1, 0.5, 0.5, 0.5, 1, 0.5, 0, 1, 1, 1, 2, 1, 1, 1, 1, 1],
  [1, 1, 0, 2, 1, 2, 0.5, 1, 2, 1, 2, 1, 0.5, 2, 1, 1, 1, 1],
  [1, 0.5, 2, 1, 0.5, 1, 2, 1, 0.5, 1, 2, 1, 1, 1, 1, 2, 1, 1],
  [1, 0.5, 0.5, 0.5, 1, 1, 1, 0.5, 0.5, 1, 0.5, 1, 2, 1, 2, 1, 1, 2],
  [0, 1, 1, 1, 1, 1, 1, 2, 0.5, 1, 1, 1, 1, 1, 2, 1, 1, 0.5],
  [1, 1, 1, 1, 1, 2, 1, 1, 0.5, 1, 0.5, 0.5, 1, 0.5, 1, 2, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 0.5, 2, 1, 2, 1, 0.5, 0.5, 2, 1, 1, 2, 0.5, 1],
  [1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 0.5, 0.5, 1, 1, 1, 0.5, 1],
  [1, 1, 0.5, 0.5, 2, 2, 0.5, 1, 0.5, 1, 0.5, 2, 0.5, 1, 1, 1, 0.5, 1],
  [1, 1, 2, 1, 0, 1, 1, 1, 1, 1, 1, 2, 0.5, 0.5, 1, 1, 0.5, 1],
  [1, 2, 1, 2, 1, 1, 1, 1, 0.5, 1, 1, 1, 1, 1, 0.5, 1, 1, 0],
  [1, 1, 2, 1, 2, 1, 1, 1, 0.5, 1, 0.5, 0.5, 2, 1, 1, 0.5, 2, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 0.5, 1, 1, 1, 1, 1, 1, 1, 2, 1],
  [1, 0.5, 1, 1, 1, 1, 1, 2, 0.5, 1, 1, 1, 1, 1, 2, 1, 1, 0.5]
];

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

List<String> stats = [
  'HP',
  'Attack',
  'Defense',
  'Sp.Attack',
  'Sp.Defense',
  'Speed',
  '&mdash;'
];
List<String> types = [
  'Normal',
  'Fighting',
  'Flying',
  'Poison',
  'Ground',
  'Rock',
  'Bug',
  'Ghost',
  'Steel',
  '???',
  'Fire',
  'Water',
  'Grass',
  'Electric',
  'Psychic',
  'Ice',
  'Dragon',
  'Dark'
];

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
  Color(0xFFA29288), //'Dark'
];

List<String> eggs = [
  '???',
  'Monster',
  'Water1',
  'Bug',
  'Flying',
  'Ground',
  'Fairy',
  'Plant',
  'Humanshape',
  'Water3',
  'Mineral',
  'Indeterminate',
  'Water2',
  'Ditto',
  'Dragon',
  'No Eggs'
];
List<String> typeshp = [
  'Fighting',
  'Flying',
  'Poison',
  'Ground',
  'Rock',
  'Bug',
  'Ghost',
  'Steel',
  'Fire',
  'Water',
  'Grass',
  'Electric',
  'Psychic',
  'Ice',
  'Dragon',
  'Dark'
];
List<String> hps = [
  '0,1,2,3,4',
  '5,6,7,8',
  '9,10,11,12',
  '13,14,15,16',
  '17,18,19,20',
  '21,22,23,24,25',
  '26,27,28,29',
  '30,31,32,33',
  '34,35,36,37',
  '38,39,40,41',
  '42,43,44,45,46',
  '47,48,49,50',
  '51,52,53,54',
  '55,56,57,58',
  '59,60,61,62',
  '63'
]; //possible Hidden Power "types"
