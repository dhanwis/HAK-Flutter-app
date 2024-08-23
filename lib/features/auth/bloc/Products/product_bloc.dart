import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/products_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductApi productApi;

  ProductBloc({required this.productApi}) : super(ProductInitial()) {
    print(this.productApi);

    on<FetchProductsEvent>(_onFetchProducts);
    on<RefreshProductsEvent>(_onRefreshProducts);
  }

  Future<void> _onFetchProducts(
      FetchProductsEvent event, Emitter<ProductState> emit) async {
    if (state is ProductsLoading) return;

    final currentState = state;
    List<Product> products = [];
    bool hasReachedMax = false;

    if (currentState is ProductsLoaded) {
      print(products.length);
      products = currentState.products;
      hasReachedMax = currentState.hasReachedMax;
    }

    if (hasReachedMax) return;

    emit(ProductsLoading());

    try {
      final newProducts = await productApi.fetchProducts(page: event.page);
      print(newProducts.length);
      hasReachedMax = newProducts.length < 10;

      emit(ProductsLoaded(
        products: products + newProducts,
        hasReachedMax: hasReachedMax,
      ));
    } catch (e) {
      print('eee');
      emit(ProductsError(message: e.toString()));
    }
  }

  Future<void> _onRefreshProducts(
      RefreshProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitial());
    add(FetchProductsEvent(page: 1));
  }
}
