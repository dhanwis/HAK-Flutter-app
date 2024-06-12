part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class ProductsFetchedState extends HomeState {
  final List<ProductsModel> productList;

 const  ProductsFetchedState({required this.productList});

}

class ProductsLoadingState extends HomeState {}

class ProductsFetchingErrorState extends HomeState {}
