import 'package:flutter/material.dart';

class ElevationCard extends StatefulWidget {
  const ElevationCard({
    super.key,
    required this.child,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8.0),
    this.shadowColor,
    this.surfaceTintColor,
    this.color,
  });

  final Widget child;
  final double? elevation;
  final EdgeInsetsGeometry padding;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final Color? color;
  @override
  State<ElevationCard> createState() => _ElevationCardState();
}

class _ElevationCardState extends State<ElevationCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(4.0));
    Color color = Theme.of(context).colorScheme.surface;
    Color shadowColor = Theme.of(context).colorScheme.shadow;
    Color surfaceTint = Theme.of(context).colorScheme.primary;

    return Material(
      borderRadius: borderRadius,
      elevation: widget.elevation ?? 0,
      color: widget.color ?? color,
      shadowColor: widget.shadowColor ?? shadowColor,
      surfaceTintColor: widget.surfaceTintColor ?? surfaceTint,
      type: MaterialType.card,
      child: Padding(
        padding: widget.padding,
        child: widget.child,
      ),
    );
  }
}
