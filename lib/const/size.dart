


import 'package:flutter/cupertino.dart';

SizedBox setHeight (double height){

  return SizedBox(height: height,);
}

SizedBox setWidth (double width){

  return SizedBox(width: width,);
}


double deviceHeight(BuildContext context){
  return MediaQuery.sizeOf(context).height;
}


double deviceWidth(BuildContext context){
  return MediaQuery.sizeOf(context).width;
}


