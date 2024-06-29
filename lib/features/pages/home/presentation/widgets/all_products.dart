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

        return _buildProductsGrid();
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
          SizedBox(
            height: 15,
          ),
          Container(
            height: 2000,
            child: ProductGrid(),
          ),
        ],
      ),
    );
  }
}
