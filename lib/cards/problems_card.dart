import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_ev_calculator/reusable/card.dart';
import 'package:provider/provider.dart';

import '../state.dart';

class ProblemsCard extends StatelessWidget {
  const ProblemsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculationState>(
      builder: (context, state, child) => state.errors.isEmpty
          ? SliverToBoxAdapter(child: Container())
          : SelectionCard(
              header: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    Icons.warning_rounded,
                    color: Colors.white.withAlpha(150),
                    size: 16,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Problems",
                      style: TextStyle(
                        color: Colors.white.withAlpha(150),
                      ),
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    for (final error in state.errors)
                      ListTile(
                        title: Text(
                          error,
                          style: const TextStyle(color: Colors.white),
                        ),
                        leading: const Icon(
                          Icons.warning_rounded,
                          color: Colors.amber,
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
