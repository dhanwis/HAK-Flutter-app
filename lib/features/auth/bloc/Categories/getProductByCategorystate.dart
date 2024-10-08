// import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
// import 'package:equatable/equatable.dart';

// abstract class ProductByCategoryState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class ProductByCategoryInitial extends ProductByCategoryState {}

// class ProductByCategoryLoading extends ProductByCategoryState {}

// class ProductsByCateogoryLoaded extends ProductByCategoryState {
//   final List<Product> products;

//   ProductsByCateogoryLoaded({required this.products});

//   @override
//   List<Object> get props => [products];
// }

// class ProductByCategoryError extends ProductByCategoryState {
//   final String message;

//   ProductByCategoryError({required this.message});

//   @override
//   List<Object> get props => [message];
// }

import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:equatable/equatable.dart';

abstract class ProductByCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductByCategoryInitial extends ProductByCategoryState {}

class ProductByCategoryLoading extends ProductByCategoryState {}

class ProductByCategoryLoaded extends ProductByCategoryState {
  final List<Product> products;

  ProductByCategoryLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductByCategoryError extends ProductByCategoryState {
  final String message;

  ProductByCategoryError(this.message);

  @override
  List<Object> get props => [message];
}
