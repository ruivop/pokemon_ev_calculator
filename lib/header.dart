import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_stats_calculator/utils.dart';

import 'cards/pokemon_selector.dart';
import 'data/pokemons.dart';
import 'generated/l10n.dart';

class Header extends StatelessWidget {
  final void Function(Species) onSpeciesChange;
  final void Function() onClear;
  final void Function() onProblemsBadgeClick;
  final Species selectedSpecies;
  final int errorCount;
  const Header({
    Key? key,
    required this.onSpeciesChange,
    required this.selectedSpecies,
    required this.onClear,
    required this.onProblemsBadgeClick,
    required this.errorCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ChoosingPokemonPageHeaderDelagate(
        onSpeciesChange,
        selectedSpecies,
        onClear,
        onProblemsBadgeClick,
        errorCount,
      ),
    );
  }
}

class ChoosingPokemonPageHeaderDelagate extends SliverPersistentHeaderDelegate {
  final double maxAppBarSize = 200;
  final double minAppBarSize = 60;

  final void Function(Species) onSpeciesChange;
  final Species selectedSpecies;
  final void Function() onClear;
  final void Function() onProblemsBadgeClick;
  final int errorCount;
  const ChoosingPokemonPageHeaderDelagate(
    this.onSpeciesChange,
    this.selectedSpecies,
    this.onClear,
    this.onProblemsBadgeClick,
    this.errorCount,
  );

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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  PokemonSearchPage(onSelect: onSpeciesChange),
            ));
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color.lerp(
                  selectedSpecies.getColorType1(), Colors.white, 0.5),
              boxShadow: isIos
                  ? null
                  : [
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
                      icon: isIos
                          ? const Icon(CupertinoIcons.back, size: 30)
                          : const Icon(Icons.arrow_back),
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
                                      alignment:
                                          selectedSpecies.variantName != null
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
                              errorCount != 0
                                  ? const SizedBox(width: 40)
                                  : const SizedBox(width: 0),
                              /*const SizedBox(width: 4),
                              const Icon(
                                Icons.refresh,
                                size: 12,
                              ),*/
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
                        showClearDialog(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          bottom: isSmall ? 12.5 : 8,
          right: isSmall ? 40 : 8,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              onProblemsBadgeClick();
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: errorCount == 0 ? 0 : 35,
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: errorCount == 0
                    ? null
                    : Row(
                        children: [
                          const Icon(Icons.warning_rounded,
                              color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            errorCount.toString(),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ],
                      )),
          ),
        ),
      ],
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

  showClearDialog(BuildContext context) {
    if (isIos) {
      return showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                title: Text(S.of(context).headerOptions),
                actions: [
                  CupertinoActionSheetAction(
                    child: Text(S.of(context).headerOptionsClear),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onClear();
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  child: Text(S.of(context).headerOptionsCancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ));
    } else {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: SizedBox(
            width: double.infinity,
            child:
                Text(S.of(context).headerOptions, textAlign: TextAlign.center),
          ),
          actionsAlignment: MainAxisAlignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 100,
                child: OutlinedButton(
                  child: Text(S.of(context).headerOptionsClear),
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
              child: Text(S.of(context).headerOptionsCancel,
                  style: const TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
