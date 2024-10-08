import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/products_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategory_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategoryState.dart';

import 'package:dil_hack_e_commerce/features/auth/model/products.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Getproductbycategorybloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final GetAllProductApi productApi;

  Getproductbycategorybloc({required this.productApi})
      : super(ProductByCategoryInitial()) {
    // Correctly attach event handlers
    on<FetchProductByCategoryEvent>(_onFetchProductByCategory);
    on<RefreshProductByCategoryEvent>(_onRefreshProductByCategory);
  }

  Future<void> _onFetchProductByCategory(FetchProductByCategoryEvent event,
      Emitter<ProductByCategoryState> emit) async {
    // Avoid loading if already loading
    if (state is ProductByCategoryLoading) return;

    emit(ProductByCategoryLoading());

    try {
      // Fetch new products based on the page from the event
      final newProducts = await productApi.fetchProducts(page: event.page);
      // Assuming that you have a list of existing products to append to
      List<Product> products = [];
      bool hasReachedMaxCategory =
          newProducts.length < 10; // Assuming 10 is the page limit

      emit(ProductsByCateogoryLoaded(
        products: products + newProducts,
        hasReachedMaxCategory: hasReachedMaxCategory,
      ));
    } catch (e) {
      emit(ProductByCategoryError(message: e.toString()));
    }
  }

  Future<void> _onRefreshProductByCategory(RefreshProductByCategoryEvent event,
      Emitter<ProductByCategoryState> emit) async {
    emit(ProductByCategoryInitial());
    // Optionally, you can also fetch products again
    add(FetchProductByCategoryEvent(
        page: 1)); // Call with the desired initial page
  }
}
