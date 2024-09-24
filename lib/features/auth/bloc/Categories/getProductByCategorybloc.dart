// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:dil_hack_e_commerce/api/products_api.dart';
// import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategory_event.dart';
// import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategoryState.dart';

// import 'package:dil_hack_e_commerce/features/auth/bloc/Products/product_bloc.dart';
// import 'package:dil_hack_e_commerce/features/auth/model/products.dart';

// class Getproductbycategorybloc
//     extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
//   final GetAllProductApi productApi;

//   Getproductbycategorybloc({required this.productApi})
//       : super(ProductByCategoryInitial()) {
//     on<FetchProductByCategoryEvent>(_onFetchProductByCateory);
//     on<RefreshProductByCategoryEvent>(_onRefreshProductByCategory);
//   }

//   Future<void> _onFetchProductByCateory(
//       FetchProductsEvent event, Emitter<ProductByCategoryState> emit) async {
//     if (state is ProductByCategoryLoading) return;

//     final currentState = state;
//     List<Product> products = [];
//     bool hasReachedMaxCategory = false;

//     if (currentState is ProductByCategoryLoading) {
//       products = currentState.products;
//       hasReachedMaxCategory = currentState.props;
//     }

//     if (hasReachedMaxCategory) return;

//     emit(ProductByCategoryLoading());

//     try {
//       final newProducts = await productApi.fetchProducts(page: event.page);

//       hasReachedMaxCategory = newProducts.length < 10;

//       emit(ProductsByCateogoryLoaded(
//         products: products + newProducts,
//         hasReachedMaxCategory: hasReachedMaxCategory,
//       ));
//     } catch (e) {
//       emit(ProductByCategoryError(message: e.toString()));
//     }
//   }

//   Future<void> _onRefreshProductByCategory(
//       RefreshProductsEvent event, Emitter<ProductByCategoryState> emit) async {
//     emit(ProductByCategoryInitial());
//     add(FetchProductByCategoryEvent());
//   }
// }
