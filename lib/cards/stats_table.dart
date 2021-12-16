import 'package:flutter/material.dart';
import 'package:pokemon_stats_calculator/cards/table_card_elements.dart' as my;
import 'package:pokemon_stats_calculator/generated/l10n.dart';
import 'package:pokemon_stats_calculator/reusable/card.dart';

import '../state.dart';
import '../utils.dart';
import 'ev_table_selector.dart';

class StatsTable extends StatelessWidget {
  final List<CalculatedStats>? statsToShow;
  final List<int?> actualStats;
  final CalculationType? calculationType;
  final bool isShowing;
  final void Function() onTogleShowing;
  const StatsTable({
    Key? key,
    required this.statsToShow,
    required this.actualStats,
    required this.calculationType,
    required this.isShowing,
    required this.onTogleShowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String labelStatsBy = S.of(context).statsTableTitleLabelSuffixUnknown;
    if (calculationType == CalculationType.ev) {
      labelStatsBy = S.of(context).statsTableTitleLabelSuffixEv;
    } else if (calculationType == CalculationType.iv) {
      labelStatsBy = S.of(context).statsTableTitleLabelSuffixIv;
    } else if (calculationType == CalculationType.stat) {
      labelStatsBy = S.of(context).statsTableTitleLabelSuffixLevel;
    }

    if (!isShowing) {
      return SelectionCard(
        header: getTitleRow(context, labelStatsBy),
        child: Center(
          child: SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: () {
                onTogleShowing();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                backgroundColor: Colors.white.withAlpha(220),
              ),
              child: Text(
                S.of(context).statsTableActivateButton(labelStatsBy),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      );
    }

    CalculatedStats unfitedMax =
        CalculatedStats(List.generate(6, (index) => ""), "?");
    CalculatedStats unfitedMin =
        CalculatedStats(List.generate(6, (index) => ""), "?");

    bool hasMax = false;
    bool hasMin = false;
    if (statsToShow != null) {
      for (var i = 0; i < actualStats.length; i++) {
        if (actualStats[i] == null) {
          continue;
        }
        int? minStat = int.tryParse(statsToShow![0].stats[i]);
        int? maxStat =
            int.tryParse(statsToShow![statsToShow!.length - 1].stats[i]);

        if (minStat != null && actualStats[i]! < minStat) {
          unfitedMin.stats[i] = actualStats[i].toString();
          hasMin = true;
        }
        if (maxStat != null && actualStats[i]! > maxStat) {
          unfitedMax.stats[i] = actualStats[i].toString();
          hasMax = true;
        }
      }
    }

    return statsToShow == null
        ? SliverToBoxAdapter(child: Container())
        : SelectionCard(
            header: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getTitleRow(context, labelStatsBy),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      right: mainBorderSide,
                    ),
                  ),
                  child: Row(
                    children: [
                      labelStatsBy,
                      S.of(context).statHP,
                      S.of(context).statAtk,
                      S.of(context).statDef,
                      S.of(context).statSpA,
                      S.of(context).statSpD,
                      S.of(context).statSpd,
                    ]
                        .map((header) => Expanded(
                                child: my.TableHeader(
                              title: header,
                              mainBorderSide: mainBorderSide,
                              textColor: textColor,
                              backgroundColor: Colors.black.withAlpha(60),
                            )))
                        .toList(),
                  ),
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(
                  right: mainBorderSide,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasMax) _showTableRow(unfitedMax),
                  for (var i = statsToShow!.length - 1; i >= 0; i--)
                    _showTableRow(statsToShow![i]),
                  if (hasMin) _showTableRow(unfitedMin),
                ],
              ),
            ),
          );
  }

  Row getTitleRow(BuildContext context, String labelStatsBy) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Icon(
          Icons.military_tech,
          color: Colors.white.withAlpha(150),
          size: 16,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).statsTableTitleLabel(labelStatsBy),
            style: TextStyle(
              color: Colors.white.withAlpha(150),
            ),
          ),
        ),
      ],
    );
  }

  my.TableRow _showTableRow(CalculatedStats rowToShow) {
    return my.TableRow(
        tableTitle: rowToShow.label,
        height: 20,
        children: [
          for (var j = 0; j < rowToShow.stats.length; j++)
            my.TableCell(
              content: rowToShow.stats[j].toString(),
              mainDecoration: actualStats[j] != null &&
                      actualStats[j].toString() == rowToShow.stats[j]
                  ? mainDecoration.copyWith(
                      color: const Color(0xff000000),
                    )
                  : mainDecoration,
              textColor: textColor,
            ),
        ],
        mainDecoration:
            mainDecoration.copyWith(color: Colors.black.withAlpha(60)),
        textColor: textColor);
  }
}
