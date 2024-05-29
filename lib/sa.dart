import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 150,
            color: Colors.red,
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Chicken',
                        style: TextStyle(fontSize: 50),
                      ),
                      Text(
                        'Chicken',
                        style: TextStyle(fontSize: 50),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
