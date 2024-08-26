import 'package:equatable/equatable.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';

abstract class NewArrivalsState extends Equatable {
  const NewArrivalsState();

  @override
  List<Object?> get props => [];
}

class NewArrivalsLoading extends NewArrivalsState {}

class NewArrivalsLoaded extends NewArrivalsState {
  final List<Product> products;

  const NewArrivalsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class NewArrivalsError extends NewArrivalsState {
  final String error;

  const NewArrivalsError(this.error);

  @override
  List<Object?> get props => [error];
}
