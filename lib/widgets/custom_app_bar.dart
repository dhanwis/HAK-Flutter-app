
import 'package:flutter/material.dart';

import '../const/colors_class.dart';
import '../const/text_style.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final Color bgColor;
  final String tittle;
  const AppBarWidget({

    super.key,required this.tittle , required this.bgColor
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(iconTheme: const IconThemeData(color: ColorsClass.white),
      centerTitle: true,

      title: Text(
        tittle,style: TextStyleClass.bona20BoldWhite,
      ),
      backgroundColor: bgColor,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


