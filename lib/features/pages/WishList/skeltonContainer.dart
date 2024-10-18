import 'package:flutter/material.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonContainer({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300], // This is the color of the skeleton
        borderRadius: borderRadius,
      ),
    );
  }
}
