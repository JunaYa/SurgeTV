import 'package:flutter/material.dart';
import 'package:surgetv/components/ElevationCard.dart';

class ElevationScreen extends StatelessWidget {
  const ElevationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color shadowColor = Theme.of(context).colorScheme.shadow;
    Color surfaceTint = Theme.of(context).colorScheme.primary;
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20, 16.0, 0),
              child: Text(
                'Surface Tint Color Only',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          ElevationGrid(
            surfaceTintColor: surfaceTint,
            shadowColor: Colors.transparent,
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                child: Text(
                  'Surface Tint Color and Shadow Color',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ]),
          ),
          ElevationGrid(
            shadowColor: shadowColor,
            surfaceTintColor: surfaceTint,
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                child: Text(
                  'Shadow Color Only',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ]),
          ),
          ElevationGrid(shadowColor: shadowColor),
        ],
      ),
    );
  }
}

const double narrowScreenWidthThreshold = 450;

class ElevationGrid extends StatelessWidget {
  const ElevationGrid({super.key, this.shadowColor, this.surfaceTintColor});

  final Color? shadowColor;
  final Color? surfaceTintColor;

  List<ElevationCard> elevationCards(
      Color? shadowColor, Color? surfaceTintColor) {
    return elevations
        .map(
          (elevationInfo) => ElevationCard(
            info: elevationInfo,
            child: const SizedBox(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverLayoutBuilder(builder: (context, constraints) {
        if (constraints.crossAxisExtent < narrowScreenWidthThreshold) {
          return SliverGrid.count(
            crossAxisCount: 3,
            children: elevationCards(shadowColor, surfaceTintColor),
          );
        } else {
          return SliverGrid.count(
            crossAxisCount: 6,
            children: elevationCards(shadowColor, surfaceTintColor),
          );
        }
      }),
    );
  }
}

const List<ElevationInfo> elevations = <ElevationInfo>[
  ElevationInfo(0, 0.0, 0),
  ElevationInfo(1, 1.0, 5),
  ElevationInfo(2, 3.0, 8),
  ElevationInfo(3, 6.0, 11),
  ElevationInfo(4, 8.0, 12),
  ElevationInfo(5, 12.0, 14),
];
