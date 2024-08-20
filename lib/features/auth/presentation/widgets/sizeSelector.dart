import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;

  SizeSelector({required this.sizes});

  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String selectedSize = '';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: widget.sizes.map((size) {
        return ChoiceChip(
          label: Text(size),
          selected: selectedSize == size,
          onSelected: (selected) {
            setState(() {
              selectedSize = selected ? size : '';
            });
          },
          selectedColor: Color(0xFFFAAAB1),
          labelStyle: TextStyle(
            color: selectedSize == size ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}
