import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class ApplyFilter extends FilterEvent {
  final Map<String, dynamic> filters;

  const ApplyFilter(this.filters);

  @override
  List<Object> get props => [filters];
}
