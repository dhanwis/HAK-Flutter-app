// ignore_for_file: public_member_api_docs, sort_constructors_first




import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingAnimation extends StatelessWidget {
  final bool isLoading;

  const LoadingAnimation({
  super.key,
    required this.isLoading,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: height,
          color:const  Color.fromARGB(9, 128, 63, 63),
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.black,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
