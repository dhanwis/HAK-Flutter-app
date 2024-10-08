import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePriceSort extends FilterEvent {
  final String priceSort;

  const UpdatePriceSort(this.priceSort);

  @override
  List<Object?> get props => [priceSort];
}

class UpdateNewest extends FilterEvent {
  final bool newest;

  const UpdateNewest(this.newest);

  @override
  List<Object?> get props => [newest];
}

class UpdateCategory extends FilterEvent {
  final String category;

  const UpdateCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdateColor extends FilterEvent {
  final String color;

  const UpdateColor(this.color);

  @override
  List<Object?> get props => [color];
}

class UpdateSize extends FilterEvent {
  final String size;

  const UpdateSize(this.size);

  @override
  List<Object?> get props => [size];
}

// filter_event.dart
class ApplyFiltersEvent extends FilterEvent {
  final Map<String, dynamic> filters;

  const ApplyFiltersEvent(this.filters);

  @override
  List<Object?> get props => [filters];
}
