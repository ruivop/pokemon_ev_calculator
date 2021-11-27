import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cards/pokemon_selector.dart';
import 'data/pokemons.dart';
import 'state.dart';

class Header extends StatelessWidget {
  final void Function(Species) onSpeciesChange;
  final void Function() onClear;
  final Species selectedSpecies;
  const Header({
    Key? key,
    required this.onSpeciesChange,
    required this.selectedSpecies,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ChoosingPokemonPageHeaderDelagate(
          onSpeciesChange, selectedSpecies, onClear),
    );
  }
}

class ChoosingPokemonPageHeaderDelagate extends SliverPersistentHeaderDelegate {
  final double maxAppBarSize = 200;
  final double minAppBarSize = 60;

  final void Function(Species) onSpeciesChange;
  final Species selectedSpecies;
  final void Function() onClear;
  const ChoosingPokemonPageHeaderDelagate(
      this.onSpeciesChange, this.selectedSpecies, this.onClear);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double currentAppBarSize = (maxAppBarSize - shrinkOffset).clamp(60, 200);
    TextStyle textStyle = TextStyle(
      fontSize: (currentAppBarSize / 4).clamp(25, 45),
      shadows: const [
        Shadow(
          blurRadius: 7,
          color: Color(0x5F888888),
          offset: Offset(2, 2),
        ),
      ],
    );
    bool isSmall = shrinkOffset > maxAppBarSize - 100;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PokemonSearchPage(onSelect: onSpeciesChange),
        ));
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.lerp(selectedSpecies.getColorType1(), Colors.white, 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Expanded(
              child: isSmall
                  ? SizedBox(
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedSpecies.number,
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: selectedSpecies.variantName != null
                                      ? Alignment.bottomCenter
                                      : Alignment.center,
                                  child: Text(
                                    selectedSpecies.name,
                                    textAlign: TextAlign.center,
                                    style: textStyle,
                                  ),
                                ),
                              ),
                              if (selectedSpecies.variantName != null)
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      selectedSpecies.variantName!,
                                      textAlign: TextAlign.center,
                                      style: textStyle.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.refresh,
                            size: 12,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedSpecies.number,
                          textAlign: TextAlign.center,
                          style: textStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedSpecies.name,
                              textAlign: TextAlign.center,
                              style: textStyle,
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.refresh),
                          ],
                        ),
                        if (selectedSpecies.variantName != null)
                          Text(
                            selectedSpecies.variantName!,
                            textAlign: TextAlign.center,
                            style: textStyle.copyWith(
                                fontSize: textStyle.fontSize! * 0.5),
                          ),
                      ],
                    ),
            ),
            SizedBox(
              height: 60,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const SizedBox(
                          width: double.infinity,
                          child: Text('Options', textAlign: TextAlign.center),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 100,
                              child: OutlinedButton(
                                child: const Text('Clear'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  onClear();
                                },
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          OutlinedButton(
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.red)),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxAppBarSize;

  @override
  double get minExtent => minAppBarSize;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
