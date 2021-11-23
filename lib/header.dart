import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cards/pokemon_selector.dart';
import 'data/pokemons.dart';
import 'state.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPersistentHeader(
      pinned: true,
      delegate: ChoosingPokemonPageHeaderDelagate(),
    );
  }
}

class ChoosingPokemonPageHeaderDelagate extends SliverPersistentHeaderDelegate {
  final double maxAppBarSize = 200;
  final double minAppBarSize = 60;

  const ChoosingPokemonPageHeaderDelagate();

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
    return Consumer<CalculationState>(
      builder: (context, state, child) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ChangeNotifierProvider<CalculationState>.value(
                    value: state, child: const PokemonSearchPage()),
          ));
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color.lerp(
                state.selectedPokemon.getColorType1(), Colors.white, 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
            /*gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.lerp(
                    state.selectedPokemon.getColorType1(), Colors.white, 0.5)!,
                state.selectedPokemon.getColorType1(),
                Color.lerp(
                    state.selectedPokemon.getColorType1(), Colors.white, 0.5)!,
              ],
            ),*/
          ),
          child: isSmall
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.selectedPokemon.number,
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      state.selectedPokemon.name,
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.selectedPokemon.number,
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                    Text(
                      state.selectedPokemon.name,
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                  ],
                ),
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
