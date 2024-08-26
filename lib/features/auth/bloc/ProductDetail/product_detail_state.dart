// product_detail_state.dart
part of 'product_detail_bloc.dart';

// product_detail_state.dart
abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final Product product;
  final List<Product> similarProducts;

  ProductDetailLoaded({required this.product, required this.similarProducts});

  ProductDetailLoaded copyWith(
      {Product? product, List<Product>? similarProducts}) {
    return ProductDetailLoaded(
      product: product ?? this.product,
      similarProducts: similarProducts ?? this.similarProducts,
    );
  }
}

class ProductDetailError extends ProductDetailState {
  final String message;

  ProductDetailError({required this.message});
}
