part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoriesEvent extends HomeEvent {}
class FetchProductEvent extends HomeEvent{}


