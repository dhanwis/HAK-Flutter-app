import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor,
          title: Image.asset(
            'assets/images/logo.png',
            height: 40,
            color: Palette.textFormBorder,
          ),
        ),
        backgroundColor: Palette.backgroundColor,
        body: ListView(
          children: const [
            Row(
              children: [],
            )
          ],
        ));
  }
}
