part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;

  ProductsLoaded({required this.products, this.hasReachedMax = false});

  @override
  List<Object> get props => [products, hasReachedMax];
}

class ProductsError extends ProductState {
  final String message;

  ProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
