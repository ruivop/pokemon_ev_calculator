import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_ev_calculator/reusable/card.dart';
import 'package:provider/provider.dart';

import '../state.dart';

class LevelSelector extends StatefulWidget {
  final LevelSelectorController? controller;
  final int nimLevel;
  final int maxLevel;
  const LevelSelector({
    Key? key,
    this.controller,
    this.nimLevel = 1,
    this.maxLevel = 100,
  }) : super(key: key);

  @override
  _LevelSelectorState createState() => _LevelSelectorState();
}

class _LevelSelectorState extends State<LevelSelector> {
  late LevelSelectorController controller;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        LevelSelectorController(
            currentLevel:
                Provider.of<CalculationState>(context, listen: false).pkmLvl);
    pageController = PageController(
      initialPage: controller.currentLevel - widget.nimLevel,
      viewportFraction: 0.3,
    );
  }

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
                "Select Pokemon Level",
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
            child: PageView.builder(
              dragStartBehavior: DragStartBehavior.down,
              controller: pageController,
              itemCount: widget.maxLevel - widget.nimLevel + 1,
              onPageChanged: (int index) {
                if (index + widget.nimLevel == controller.currentLevel) return;
                setState(() {
                  controller.currentLevel = index + widget.nimLevel;
                });
                Provider.of<CalculationState>(context, listen: false)
                    .setNewLevel(index + widget.nimLevel);
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration:
                      controller.currentLevel == (index + widget.nimLevel)
                          ? BoxDecoration(
                              color: Colors.grey.withAlpha(100),
                              border: Border.all(
                                color: Colors.white.withAlpha(150),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            )
                          : null,
                  child: Center(
                    child: Text(
                      (index + widget.nimLevel)
                          .toString(), //controller.currentLevel.toString(),
                      style: TextStyle(
                        fontSize:
                            controller.currentLevel == (index + widget.nimLevel)
                                ? 50
                                : 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withAlpha(150),
            min: widget.nimLevel.toDouble(),
            max: widget.maxLevel.toDouble(),
            value: controller.currentLevel.toDouble(),
            onChanged: (value) {
              controller.currentLevel = value.toInt();
              pageController.jumpToPage(value.toInt() - widget.nimLevel);
              setState(() {});
              Provider.of<CalculationState>(context, listen: false)
                  .setNewLevel(value.toInt());
            },
          )
        ],
      ),
    );
  }
}

class LevelSelectorController {
  int currentLevel;
  LevelSelectorController({
    this.currentLevel = 50,
  });
}
