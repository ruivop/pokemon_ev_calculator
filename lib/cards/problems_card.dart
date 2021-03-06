import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_stats_calculator/generated/l10n.dart';
import 'package:pokemon_stats_calculator/reusable/card.dart';
import 'package:pokemon_stats_calculator/state.dart';

class ProblemsCard extends StatelessWidget {
  final List<CError> errors;
  const ProblemsCard({
    Key? key,
    required this.errors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return errors.isEmpty
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
                    S.of(context).problemsTitle,
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
                  for (final error in errors)
                    ListTile(
                      title: Text(
                        error.message(context),
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
          );
  }
}
