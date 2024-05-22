import 'package:flutter/material.dart';

class Listt extends StatelessWidget{
  const Listt({super.key});
  @override
 Widget build(BuildContext context ){
  return Scaffold(body: ListView(
    physics: AlwaysScrollableScrollPhysics(),
    children: [
    SizedBox(height: 300,
    child: ListView.builder(
      physics: ScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context,index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(height: 200,color: Colors.amber,),
      );
    }),
    ),

    SizedBox(height: 50,), SizedBox(height: 300,
    child: ListView.builder(itemBuilder: (context,index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(height: 200,color: Colors.amber,),
      );
    }),
    ),

    SizedBox(height: 50,), SizedBox(height: 300,
    child: ListView.builder(
      physics: ClampingScrollPhysics(),
      itemBuilder: (context,index){
      
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(height: 200,color: Colors.amber,),
      );
    }),
    ),

    SizedBox(height: 50,)

  ],),);
 }
  
}