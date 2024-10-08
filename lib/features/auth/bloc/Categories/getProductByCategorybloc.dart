// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:dil_hack_e_commerce/api/productByCategory.dart';

// import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategory_event.dart';
// import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategoryState.dart';

// import 'package:dil_hack_e_commerce/features/auth/model/products.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductByCategoryBloc
//     extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
//   final GetProductsByCategory productApi;

//   ProductByCategoryBloc({required this.productApi})
//       : super(ProductByCategoryInitial()) {
//     on<FetchProductByCategoryEvent>(_onFetchProductByCategory);
//     //on<RefreshProductByCategoryEvent>(_onRefreshProductByCategory);
//   }

//   Future<void> _onFetchProductByCategory(FetchProductByCategoryEvent event,
//       Emitter<ProductByCategoryState> emit) async {
//     // Avoid loading if already loading
//     if (state is ProductByCategoryLoading) return;

//     // emit(ProductByCategoryLoading());

//     try {
//       // Fetch new products based on the page from the event
//       final newProducts =
//           await productApi.fetchProductByCategoryId(event.categoryId);
//       // Assuming that you have a list of existing products to append to
//       List<Product> products = [];

//       emit(ProductsByCateogoryLoaded(
//         products: products + newProducts,
//       ));
//     } catch (e) {
//       emit(ProductByCategoryError(message: e.toString()));
//     }
//   }
// }

import 'package:dil_hack_e_commerce/api/productByCategory.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategory_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategorystate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final GetProductsByCategory
      productsByCategoryApi; // Assume you have a repository

  ProductByCategoryBloc(this.productsByCategoryApi)
      : super(ProductByCategoryInitial()) {
    // Use the on<Event> method to handle specific events
    on<FetchProductsByCategory>(_onFetchProductsByCategory);
  }

  // Define the event handler method
  Future<void> _onFetchProductsByCategory(FetchProductsByCategory event,
      Emitter<ProductByCategoryState> emit) async {
    emit(ProductByCategoryLoading());
    try {
      final products = await productsByCategoryApi
          .fetchProductByCategoryId(event.categoryId);
      emit(ProductByCategoryLoaded(products));
    } catch (e) {
      emit(ProductByCategoryError('Failed to fetch products'));
    }
  }
}
