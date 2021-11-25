import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SelectionCard extends StatelessWidget {
  final Widget child;
  final Widget header;
  final Color? color;
  const SelectionCard({
    Key? key,
    required this.child,
    required this.header,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPinnedHeader(
          child: Container(
              margin: const EdgeInsets.only(right: 16, left: 16, top: 8),
              padding: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: color ?? Colors.black.withAlpha(40),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: header),
        ),
        SliverClip(
          child: SliverToBoxAdapter(
            child: Container(
                margin: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
                padding: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: color ?? Colors.black.withAlpha(40),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: child),
          ),
        ),
      ],
    );
  }
}
