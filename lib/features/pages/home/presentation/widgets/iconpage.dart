import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class IconsPage extends StatelessWidget {
  final List<IconData> icons;

  const IconsPage({Key? key, required this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Icons Page'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return Icon(icons[index], size: 50);
        },
      ),
    );
  }
}
