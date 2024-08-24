part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductsEvent extends ProductEvent {
  final int page;

  FetchProductsEvent({this.page = 1});

  @override
  List<Object> get props => [page];
}

class RefreshProductsEvent extends ProductEvent {}
