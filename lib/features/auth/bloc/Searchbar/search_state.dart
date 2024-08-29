// search_state.dart
import 'package:equatable/equatable.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Product> products;

  const SearchSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class SearchFailure extends SearchState {
  final String error;

  const SearchFailure(this.error);

  @override
  List<Object?> get props => [error];
}
