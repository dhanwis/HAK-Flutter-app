import 'package:equatable/equatable.dart';
import 'package:dil_hack_e_commerce/features/auth/model/categories.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoryState {}

class CategoriesLoading extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<Category> categories;

  CategoriesLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoriesError extends CategoryState {
  final String error;

  CategoriesError({required this.error});

  @override
  List<Object?> get props => [error];
}
