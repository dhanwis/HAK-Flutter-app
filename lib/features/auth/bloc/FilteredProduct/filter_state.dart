import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final String? priceSort;
  final bool? newest;
  final String? category;
  final String? color;
  final String? size;

  const FilterState({
    this.priceSort,
    this.newest,
    this.category,
    this.color,
    this.size,
  });

  // Create a copy of the state with updated values
  FilterState copyWith({
    String? priceSort,
    bool? newest,
    String? category,
    String? color,
    String? size,
  }) {
    return FilterState(
      priceSort: priceSort ?? this.priceSort,
      newest: newest ?? this.newest,
      category: category ?? this.category,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  @override
  List<Object?> get props => [priceSort, newest, category, color, size];
}
