

import 'package:flutter/material.dart';
class ColorsClass {
  static const white = Colors.white;
 static const primaryColorPurple = Color(0xFF7F3DFF);
 static const  lightPurple = Color(0xFFEEE5FF);

  static const black = Colors.black;
  static const grey = Colors.grey;
  static const lightGray = Color(0xFFfF1F1FA);
  static const lightGray2 = Color(0xffbebdbd);
  static const  yellow20 = Color(0xffF8EDD8);
  static const  yellow10 = Color(0xffFFF6E5);
  static const red = Colors.red;
  static const green = Color(0xff00A86B);
  static const yellow100 = Color(0xfffcac12);
  static const baseLightDark = Color(0xDCF5F5F5);


// melp

 static const primaryColor = Color(0xff968267);
 static const lightGray3 = Color(0xffEBEBEB);


}


class GradiantClass {
 static  lightYellowGradiant ()=> LinearGradient(
  begin: Alignment.topCenter,end: Alignment.bottomCenter,

     colors: [ColorsClass.yellow10,ColorsClass.yellow20,ColorsClass.yellow10,ColorsClass.yellow10.withOpacity(0.1)]);

}
