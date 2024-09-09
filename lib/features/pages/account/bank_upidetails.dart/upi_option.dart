import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpiOptionButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const UpiOptionButton({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style:
                GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
