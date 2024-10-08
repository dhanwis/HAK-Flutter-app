




import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../const/icon_class.dart';
import '../const/size.dart';
import '../const/text_style.dart';

class GoogleButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onTap;
  final double? height ;

  const GoogleButton({super.key, this.onTap, this.label, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconClass.googleIcon,height:height??25,
          ),
          setWidth(20),
          Text(
            label ?? "",
            style: TextStyleClass.bonaGrey20,
          )
        ],
      ),
    );
  }
}
