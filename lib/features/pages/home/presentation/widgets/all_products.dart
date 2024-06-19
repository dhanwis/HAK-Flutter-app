import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dil_hack_e_commerce/features/pages/home/presentation/bloc/home_bloc.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_adding.dart'; // Adjust import as per your project structure

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    print('build called');

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is ProductsLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductsFetchedState) {
          print(state.productList.length);
          return ListView.builder(
            itemCount: state.productList.length,
            itemBuilder: (context, index) {
              print(index.toString());
              final product = state.productList[index];
              // return ProductItem(product: product);
            },
          );
        } else if (state is ProductsFetchingErrorState) {
          return _buildProductsGrid();
        }

        return _buildProductsGrid(); // Fallback to showing predefined products
      },
    );
  }

  Widget _buildProductsGrid() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Products For you',
            style: GoogleFonts.aBeeZee(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          //ProductGrid(products: products), // Display predefined products
        ],
      ),
    );
  }
}

Widget _buildProductsGrid() {
  final predefinedProducts = [
    ProductsModel(
      name: 'Trendy Superior Sarees',
      price: 424,
      imageUrl: 'URL_TO_IMAGE_1', // Replace with actual image URL
    ),
    ProductsModel(
      name: 'Aagyeyi Attractive Sarees',
      price: 309,
      imageUrl: 'URL_TO_IMAGE_2', // Replace with actual image URL
    ),
    ProductsModel(
      name: 'Kashvi Refined Sarees',
      price: 292,
      imageUrl: 'URL_TO_IMAGE_3', // Replace with actual image URL
    ),
    ProductsModel(
      name: 'Adrika Pretty Sarees',
      price: 630,
      imageUrl: 'URL_TO_IMAGE_4', // Replace with actual image URL
    ),
    // Add more predefined products as needed
  ];

  return Padding(
    padding: const EdgeInsets.only(left: 20, top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products For you',
          style: GoogleFonts.aBeeZee(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),

        // Expanded(
        //   child: GridView.builder(
        //     padding: const EdgeInsets.all(8),
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       crossAxisSpacing: 8,
        //       mainAxisSpacing: 8,
        //     ),
        //     itemCount: predefinedProducts.length,
        //     itemBuilder: (context, index) {
        //       final product = predefinedProducts[index];
        //       print(product);
        //       return ProductItem(product: product);
        //     },
        //   ),
        // ),
      ],
    ),
  );
}
