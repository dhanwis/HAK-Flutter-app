// product_detail_event.dart
part of 'product_detail_bloc.dart';

// product_detail_event.dart
abstract class ProductDetailEvent {}

class FetchProductDetails extends ProductDetailEvent {
  final String productId;

  FetchProductDetails(this.productId);
}

class FetchSimilarProducts extends ProductDetailEvent {
  final String productId;

  FetchSimilarProducts(this.productId);
}
