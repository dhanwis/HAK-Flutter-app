

import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/bloc/home_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(99, 202, 201, 202),
                ),
                child: TextFormField(
                  style: const TextStyle(color: Palette.shadowPink),
                  cursorColor: Colors.grey.shade50,
                  decoration: InputDecoration(
                      hintText: 'Search Products',
                      hintStyle: GoogleFonts.aBeeZee(
                          color: const Color.fromARGB(255, 182, 182, 182)),
                      prefixIcon: const Icon(
                        EvaIcons.search,
                        color: Color.fromARGB(255, 175, 174, 174),
                      ),
                      contentPadding: const EdgeInsets.only(top: 13),
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<HomeBloc>(context).add(FetchCategoriesEvent());
          },
          child: Padding(
            padding: const EdgeInsets.only( right: 10),
            child: Container(
              height:50,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 235, 228, 228),
                  borderRadius: BorderRadius.circular(15)),

              width: 60,
              child: const Center(
                child: Icon(
                  EvaIcons.arrowForward,
                  color: Color.fromARGB(255, 147, 144, 144),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
