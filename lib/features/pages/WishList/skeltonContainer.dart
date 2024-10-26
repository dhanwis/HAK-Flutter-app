import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonContainer({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = BorderRadius.zero,
    required BoxShape shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300], // Fallback color for skeleton
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
