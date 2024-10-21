import 'package:flutter/material.dart';

class ElevationCard extends StatefulWidget {
  const ElevationCard({
    super.key,
    required this.info,
    required this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.shadowColor,
    this.surfaceTintColor,
  });

  final ElevationInfo info;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? shadowColor;
  final Color? surfaceTintColor;

  @override
  State<ElevationCard> createState() => _ElevationCardState();
}

class _ElevationCardState extends State<ElevationCard> {
  late double _elevation;

  @override
  void initState() {
    super.initState();
    _elevation = widget.info.elevation;
  }

  @override
  Widget build(BuildContext context) {
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(4.0));
    final Color color = Theme.of(context).colorScheme.surface;
    Color shadowColor = Theme.of(context).colorScheme.shadow;
    Color surfaceTint = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: borderRadius,
        elevation: _elevation,
        color: color,
        shadowColor: widget.shadowColor ?? shadowColor,
        surfaceTintColor: widget.surfaceTintColor ?? surfaceTint,
        type: MaterialType.card,
        child: Padding(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}

class ElevationInfo {
  const ElevationInfo(this.level, this.elevation, this.overlayPercent);
  final int level;
  final double elevation;
  final int overlayPercent;
}
