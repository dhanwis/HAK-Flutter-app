// product_detail_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/productById_api.dart';
import 'package:dil_hack_e_commerce/api/similar_product_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

// product_detail_bloc.dart
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductbyidApi productApi;
  final GetSimilarProductsApi similarProductsApi;

  ProductDetailBloc(
      {required this.productApi, required this.similarProductsApi})
      : super(ProductDetailInitial()) {
    on<FetchProductDetails>(_onFetchProductDetails);
    on<FetchSimilarProducts>(_onFetchSimilarProducts);
  }

  Future<void> _onFetchProductDetails(
      FetchProductDetails event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      final product = await productApi.fetchProductById(event.productId);
      emit(ProductDetailLoaded(product: product, similarProducts: []));
      add(FetchSimilarProducts(event
          .productId)); // Fetch similar products after product details are loaded
    } catch (e) {
      emit(ProductDetailError(message: 'Failed to load product'));
    }
  }

  Future<void> _onFetchSimilarProducts(
      FetchSimilarProducts event, Emitter<ProductDetailState> emit) async {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      try {
        final similarProducts =
            await similarProductsApi.fetchSimilarProductById(event.productId);
        emit(currentState.copyWith(similarProducts: similarProducts));
      } catch (e) {
        emit(ProductDetailError(message: 'Failed to load similar products'));
      }
    }
  }
}
