// category_widget.dart
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/category_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/category_state.dart';
import 'package:dil_hack_e_commerce/features/auth/model/categories.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productsByCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return Skeletonizer(
            enabled: true,
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 37,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 80,
                        height: 15,
                        color: Colors.grey.shade200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is CategoriesError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is CategoriesLoaded) {
          List<Category> categories = state.categories;
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsByCategory(
                                  categoryId: categories[index].id,
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 37,
                            backgroundImage: NetworkImage(
                              "${AppConstants.CATEOGRYIMG}/${categories[index].imageUrl}",
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          categories[index].label,
                          style: GoogleFonts.aBeeZee(
                            letterSpacing: 1,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center();
        }
      },
    );
  }
}
