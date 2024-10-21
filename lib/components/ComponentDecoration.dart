import 'package:flutter/material.dart';

const tinySpacing = 3.0;
const smallSpacing = 10.0;
const double widthConstraint = 450;

class ComponentDecoration extends StatefulWidget {
  const ComponentDecoration({
    super.key,
    this.label,
    required this.child,
    this.tooltipMessage = '',
    this.elevation = 0,
  });

  final String? label;
  final Widget child;
  final String? tooltipMessage;
  final double elevation;

  @override
  State<ComponentDecoration> createState() => _ComponentDecorationState();
}

class _ComponentDecorationState extends State<ComponentDecoration> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: smallSpacing),
        child: Column(
          children: [
            widget.label != null && widget.label!.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.label!,
                          style: Theme.of(context).textTheme.titleMedium),
                      Tooltip(
                        message: widget.tooltipMessage,
                        child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Icon(Icons.info_outline, size: 16)),
                      ),
                    ],
                  )
                : const SizedBox(),
            ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(width: widthConstraint),
              // Tapping within the a component card should request focus
              // for that component's children.
              child: Focus(
                focusNode: focusNode,
                canRequestFocus: true,
                child: GestureDetector(
                  onTapDown: (_) {
                    focusNode.requestFocus();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Card(
                    elevation: widget.elevation,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: Center(
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
