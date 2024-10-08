// import 'package:equatable/equatable.dart';

// abstract class ProductByCategoryEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class FetchProductByCategoryEvent extends ProductByCategoryEvent {
//   final String categoryId;

//   FetchProductByCategoryEvent(this.categoryId);
// }

// class RefreshProductByCategoryEvent extends ProductByCategoryEvent {}

import 'package:equatable/equatable.dart';

abstract class ProductByCategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductsByCategory extends ProductByCategoryEvent {
  final String categoryId;

  FetchProductsByCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
