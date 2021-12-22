import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_stats_calculator/data/pokemons.dart';
import 'package:pokemon_stats_calculator/data/stats.dart';
import 'package:pokemon_stats_calculator/generated/l10n.dart';
import 'package:pokemon_stats_calculator/reusable/card.dart';
import 'package:pokemon_stats_calculator/utils.dart';

class NatureSelector extends StatelessWidget {
  final Species selectedPokemon;
  final int? natureIndex;
  final void Function(int) onNatureChanged;
  const NatureSelector({
    Key? key,
    required this.selectedPokemon,
    required this.natureIndex,
    required this.onNatureChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      header: Row(
        children: [
          const SizedBox(width: 16),
          Icon(
            CupertinoIcons.leaf_arrow_circlepath,
            color: Colors.white.withAlpha(150),
            size: 16,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).natureSelectorTitle,
              style: TextStyle(
                color: Colors.white.withAlpha(150),
              ),
            ),
          ),
        ],
      ),
      child: SizedBox(
        height: 80,
        child: Center(
          child: SizedBox(
            width: 250,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => NatureSelectorPage(
                      natureIndex: natureIndex,
                      onNatureChanged: onNatureChanged,
                      backgroundColor: selectedPokemon.getColorType1()),
                ));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (natureIndex == null || natureIndex == 0)
                    const Icon(Icons.warning_rounded, color: Colors.amber),
                  Expanded(
                    child: Center(
                      child: Text(
                          natureIndex == null || natureIndex == 0
                              ? S.of(context).natureSelectorNoNatureSelected
                              : getNatureNameById(natureIndex!),
                          style: const TextStyle(fontSize: 22)),
                    ),
                  ),
                ],
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                backgroundColor: Colors.white.withAlpha(220),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NatureSelectorPage extends StatelessWidget {
  final Color backgroundColor;

  final int? natureIndex;
  final void Function(int) onNatureChanged;

  const NatureSelectorPage({
    Key? key,
    required this.backgroundColor,
    required this.natureIndex,
    required this.onNatureChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var types = [
      S.of(context).statAtk,
      S.of(context).statDef,
      S.of(context).statSpA,
      S.of(context).statSpD,
      S.of(context).statSpd
    ];
    var luminance = backgroundColor.computeLuminance();
    return getHeader(
      context,
      luminance,
      ListView.builder(
        itemCount: natureNames.length,
        itemBuilder: (context, index) => Container(
          color: isSelected(index, natureIndex)
              ? backgroundColor.withAlpha(100)
              : index % 2 == 0
                  ? Colors.white
                  : Colors.grey.withAlpha(10),
          child: ListTile(
            leading: isSelected(index, natureIndex)
                ? const Icon(Icons.radio_button_checked)
                : const Icon(Icons.radio_button_unchecked),
            title: Text(natureNames[index].name),
            trailing: index == 0
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < 5; i++)
                        Container(
                          decoration: BoxDecoration(
                            color: natures[natureNames[index].id][i] > 1
                                ? Colors.green
                                : natures[natureNames[index].id][i] < 1
                                    ? Colors.red
                                    : null,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            types[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: natures[natureNames[index].id][i] == 1
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                    ],
                  ),
            onTap: () {
              onNatureChanged(natureNames[index].id);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  bool isSelected(int index, int? stateNatureIndex) {
    return (stateNatureIndex == null && index == 0) ||
        (stateNatureIndex != null && stateNatureIndex == natureNames[index].id);
  }

  getHeader(BuildContext context, double luminance, Widget child) {
    return isIos
        ? CupertinoTheme(
            data: CupertinoThemeData(
                brightness:
                    luminance < 0.5 ? Brightness.dark : Brightness.light,
                primaryColor: luminance > 0.5 ? Colors.black : Colors.white),
            child: CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text(S.of(context).natureSelectorScreenTitle),
                  backgroundColor: backgroundColor,
                  brightness:
                      luminance < 0.5 ? Brightness.dark : Brightness.light,
                ),
                child: SafeArea(child: Material(child: child))),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).natureSelectorScreenTitle),
              backgroundColor: backgroundColor,
              foregroundColor: luminance > 0.5 ? Colors.black : Colors.white,
              systemOverlayStyle: luminance > 0.5
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
            ),
            body: child,
          );
  }
}
