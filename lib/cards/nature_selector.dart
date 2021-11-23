import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_ev_calculator/data/stats.dart';
import 'package:pokemon_ev_calculator/reusable/card.dart';
import 'package:pokemon_ev_calculator/state.dart';
import 'package:provider/provider.dart';

class NatureSelector extends StatelessWidget {
  const NatureSelector({Key? key}) : super(key: key);

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
                "Select Nature",
                style: TextStyle(
                  color: Colors.white.withAlpha(150),
                ),
              ),
            ),
          ],
        ),
        child: Consumer<CalculationState>(
          builder: (context, state, child) => SizedBox(
            height: 80,
            child: Center(
              child: SizedBox(
                width: 200,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          ChangeNotifierProvider<CalculationState>.value(
                              value: state,
                              child: NatureSelectorPage(
                                  backgroundColor:
                                      state.selectedPokemon.getColorType1())),
                    ));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.pkmNature == null || state.pkmNature == 0)
                        const Icon(Icons.warning_rounded, color: Colors.amber),
                      Expanded(
                        child: Center(
                          child: Text(
                              state.pkmNature == null || state.pkmNature == 0
                                  ? "Select Nature"
                                  : getNatureNameById(state.pkmNature!),
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
        ));
  }
}

class NatureSelectorPage extends StatelessWidget {
  final Color backgroundColor;
  const NatureSelectorPage({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Nature"),
        backgroundColor: backgroundColor,
        foregroundColor: backgroundColor.computeLuminance() > 0.5
            ? Colors.black
            : Colors.white,
      ),
      body: Consumer<CalculationState>(
        builder: (context, state, child) => ListView.builder(
          itemCount: natureNames.length,
          itemBuilder: (context, index) => Container(
            color: isSelected(index, state)
                ? backgroundColor.withAlpha(100)
                : index % 2 == 0
                    ? Colors.white
                    : Colors.grey.withAlpha(10),
            child: ListTile(
              leading: isSelected(index, state)
                  ? const Icon(Icons.radio_button_checked)
                  : const Icon(Icons.radio_button_unchecked),
              title: Text(natureNames[index].name),
              onTap: () {
                state.setNewNature(natureNames[index].id);
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  bool isSelected(int index, CalculationState state) {
    return (state.pkmNature == null && index == 0) ||
        (state.pkmNature != null && state.pkmNature == natureNames[index].id);
  }
}
