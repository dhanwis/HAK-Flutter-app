import 'package:dil_hack_e_commerce/features/auth/bloc/Products/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductsLoaded) {
          return ListView.builder(
            itemCount: state.hasReachedMax
                ? state.products.length
                : state.products.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.products.length) {
                context.read<ProductBloc>().add(
                    FetchProductsEvent(page: state.products.length ~/ 10 + 1));
                return Center(child: CircularProgressIndicator());
              }
              final product = state.products[index];
              return ListTile(
                title: Text(product.productName),
                subtitle: Text(product.productDescription),
              );
            },
          );
        } else if (state is ProductsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Center(child: Text('No Products Found'));
      },
    );
  }
}

Widget _buildHeader() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      'Products For you',
      style: GoogleFonts.aBeeZee(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget _buildProductsGrid() {
  return Column(
    children: [
      _buildHeader(),
      Expanded(
        child: Center(
          child: Text('Loading products...'),
        ),
      ),
    ],
  );
}
