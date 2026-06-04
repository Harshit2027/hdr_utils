import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../extensions/context_extensions.dart';
import '../extensions/color_extensions.dart';

/// Wraps any [child] widget and applies a shimmer animation gradient over it.
class HdrCustomShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const HdrCustomShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final defaultBase = baseColor ?? colorScheme.onSurface.applyOpacity(0.1);
    final defaultHighlight =
        highlightColor ?? colorScheme.surface.applyOpacity(0.3);

    return Shimmer.fromColors(
      baseColor: defaultBase,
      highlightColor: defaultHighlight,
      child: child,
    );
  }
}

/// A simple colored box placeholder showing a shimmer animation.
/// Useful for building content loading skeletons.
class HdrSkeletonShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;
  final Color? baseColor;
  final Color? highlightColor;

  const HdrSkeletonShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.baseColor,
    this.highlightColor,
  });

  /// Creates a circular skeleton shimmer.
  const HdrSkeletonShimmer.circular({
    super.key,
    double size = 24,
    this.baseColor,
    this.highlightColor,
  }) : width = size,
       height = size,
       shape = BoxShape.circle,
       borderRadius = null;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final defaultBase = baseColor ?? colorScheme.onSurface.applyOpacity(0.1);
    final defaultHighlight =
        highlightColor ?? colorScheme.surface.applyOpacity(0.3);

    return Shimmer.fromColors(
      baseColor: defaultBase,
      highlightColor: defaultHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colorScheme.surface.applyOpacity(0.9),
          borderRadius: shape == BoxShape.circle
              ? null
              : (borderRadius ?? BorderRadius.circular(8)),
          shape: shape,
        ),
      ),
    );
  }
}
