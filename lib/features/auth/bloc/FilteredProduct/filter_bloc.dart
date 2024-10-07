import 'package:dil_hack_e_commerce/api/filter_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final FilteredProduct _productApi;

  FilterBloc(this._productApi) : super(FilterInitial()) {
    on<ApplyFilter>(_onApplyFilter);
  }

  Future<void> _onApplyFilter(
      ApplyFilter event, Emitter<FilterState> emit) async {
    emit(FilterLoading());
    try {
      print('object is loading');
      // Fetch products based on the applied filters
      final products = await _productApi.fetchFilteredProducts(
        event.filters['categoryId'],
      );
      emit(FilterLoaded(products));
    } catch (e) {
      print('er $e');
      emit(FilterError('Failed to load filtered products: ${e.toString()}'));
    }
  }
}
