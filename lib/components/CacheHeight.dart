import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CacheHeight extends SingleChildRenderObjectWidget {
  const CacheHeight({
    super.key,
    super.child,
    required this.heights,
    required this.index,
  });

  final List<double?> heights;
  final int index;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCacheHeight(
      heights: heights,
      index: index,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderCacheHeight renderObject) {
    renderObject
      ..heights = heights
      ..index = index;
  }
}

class _RenderCacheHeight extends RenderProxyBox {
  _RenderCacheHeight({
    required List<double?> heights,
    required int index,
  })  : _heights = heights,
        _index = index,
        super();

  List<double?> _heights;
  List<double?> get heights => _heights;
  set heights(List<double?> value) {
    if (value == _heights) {
      return;
    }
    _heights = value;
    markNeedsLayout();
  }

  int _index;
  int get index => _index;
  set index(int value) {
    if (value == index) {
      return;
    }
    _index = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    super.performLayout();
    heights[index] = size.height;
  }
}
