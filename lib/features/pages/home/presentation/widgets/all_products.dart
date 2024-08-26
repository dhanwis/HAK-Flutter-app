import 'package:dil_hack_e_commerce/features/auth/bloc/Products/product_bloc.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    // Fetch initial products
    context.read<ProductBloc>().add(FetchProductsEvent(page: 1));
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final productBloc = context.read<ProductBloc>();
      final currentState = productBloc.state;
      if (currentState is ProductsLoaded && !currentState.hasReachedMax) {
        productBloc.add(
            FetchProductsEvent(page: (currentState.products.length ~/ 10) + 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductsLoading &&
            (state.products == null || state.products!.isEmpty)) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductsLoaded) {
          // return Expanded(
          //   child: ListView.builder(
          //     controller: _scrollController,
          //     itemCount: state.products.length + 1,
          //     itemBuilder: (context, index) {
          //       if (index == state.products.length) {
          //         // Bottom loader
          //         return state.hasReachedMax
          //             ? SizedBox.shrink() // No more items to load
          //             : Center(child: CircularProgressIndicator());
          //       }

          //       final product = state.products[index];
          //       return ListTile(
          //         title: Text(product.productName),
          //         subtitle: Text(product.productDescription),
          //       );
          //     },
          //   ),
          // );
          return Expanded(
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
                SizedBox(height: 15),
                Container(
                  height: 1000,
                  child: ProductGrid(),
                )
              ],
            ),
          );
        } else if (state is ProductsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Center(child: Text('No Products Found'));
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
