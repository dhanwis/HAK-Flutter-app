import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:equatable/equatable.dart';

abstract class ProductByCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductByCategoryInitial extends ProductByCategoryState {}

class ProductByCategoryLoading extends ProductByCategoryState {
  get products => null;
}

class ProductsByCateogoryLoaded extends ProductByCategoryState {
  final List<Product> products;
  final bool hasReachedMaxCategory;

  ProductsByCateogoryLoaded(
      {required this.products, this.hasReachedMaxCategory = false});

  @override
  List<Object> get props => [products, hasReachedMaxCategory];
}

class ProductByCategoryError extends ProductByCategoryState {
  final String message;

  ProductByCategoryError({required this.message});

  @override
  List<Object> get props => [message];
}
