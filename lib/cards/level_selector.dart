import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pokemon_stats_calculator/generated/l10n.dart';
import 'package:pokemon_stats_calculator/reusable/card.dart';

class LevelSelector extends StatefulWidget {
  final int nimLevel;
  final int maxLevel;

  final int level;
  final void Function(int) onLevelChanged;
  const LevelSelector({
    Key? key,
    this.nimLevel = 1,
    this.maxLevel = 100,
    required this.level,
    required this.onLevelChanged,
  }) : super(key: key);

  @override
  State<LevelSelector> createState() => _LevelSelectorState();
}

class _LevelSelectorState extends State<LevelSelector> {
  bool isChangingBottom = false;
  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      header: Row(
        children: [
          const SizedBox(width: 16),
          Icon(
            CupertinoIcons.slider_horizontal_below_rectangle,
            color: Colors.white.withAlpha(150),
            size: 16,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).levelSelectorScreenTitle,
                style: TextStyle(
                  color: Colors.white.withAlpha(150),
                ),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 80,
            child: NumberPicker(
                value: widget.level,
                minValue: widget.nimLevel,
                maxValue: widget.maxLevel,
                onChanged: (value) {
                  if (!isChangingBottom) {
                    widget.onLevelChanged(value);
                  }
                },
                axis: Axis.horizontal,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(100),
                  border: Border.all(
                    color: Colors.white.withAlpha(150),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                )),
          ),
          Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withAlpha(150),
            min: widget.nimLevel.toDouble(),
            max: widget.maxLevel.toDouble(),
            value: widget.level.toDouble(),
            onChangeStart: (value) {
              isChangingBottom = true;
            },
            onChangeEnd: (value) {
              Timer(const Duration(milliseconds: 500), () {
                isChangingBottom = false;
              });
            },
            onChanged: (value) {
              widget.onLevelChanged(value.round());
            },
          )
        ],
      ),
    );
  }
}
