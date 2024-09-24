import 'package:equatable/equatable.dart';

abstract class ProductByCategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductByCategoryEvent extends ProductByCategoryEvent {
  final int page;

  FetchProductByCategoryEvent({this.page = 1});

  @override
  List<Object> get props => [page];
}

class RefreshProductByCategoryEvent extends ProductByCategoryEvent {}
