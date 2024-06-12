


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.icons,
  });

  final List icons;

  @override
  Widget build(BuildContext context) {
    List<String> labels = [
      'Saree',
      'TShirts',
      'Kurti',
      'Lehanka',
      'Salwar',
      'Western',
      'Traditional'
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1, 1),
                              blurRadius: 10)
                        ],
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(99, 202, 201, 202),
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Icon(
                        icons[index],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    labels[index],
                    style: GoogleFonts.aBeeZee(letterSpacing: 1),
                  )
                ],
              ),
            );
          }),
    );
  }
}