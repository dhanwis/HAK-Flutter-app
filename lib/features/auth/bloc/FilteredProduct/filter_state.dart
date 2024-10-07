import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:equatable/equatable.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final List<Product> products;

  const FilterLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class FilterError extends FilterState {
  final String message;

  const FilterError(this.message);

  @override
  List<Object> get props => [message];
}
