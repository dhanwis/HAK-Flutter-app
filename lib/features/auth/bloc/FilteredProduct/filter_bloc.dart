import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/filter_api.dart';
import 'package:dil_hack_e_commerce/api/new_arrivals_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/category_state.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/NewArrivals/new_arrivals_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/NewArrivals/new_arrivals_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/NewArrivals/new_arrivals_state.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<UpdatePriceSort>((event, emit) {
      final newState = state.copyWith(priceSort: event.priceSort);

      emit(newState);
      _fetchProductsBasedOnFilters(newState);
    });

    on<UpdateNewest>((event, emit) {
      final newState = state.copyWith(newest: event.newest);
      emit(newState);
      _fetchProductsBasedOnFilters(newState);
    });

    on<UpdateCategory>((event, emit) {
      final newState = state.copyWith(category: event.category);
      emit(newState);
      _fetchProductsBasedOnFilters(newState);
    });

    on<UpdateColor>((event, emit) {
      final newState = state.copyWith(color: event.color);
      emit(newState);
      _fetchProductsBasedOnFilters(newState);
    });

    on<UpdateSize>((event, emit) {
      final newState = state.copyWith(size: event.size);
      emit(newState);
      _fetchProductsBasedOnFilters(newState);
    });

    on<ApplyFiltersEvent>((event, emit) {
      // Update state with the provided filters
      final newState = state.copyWith(
        priceSort: event.filters['priceSort'],
        newest: event.filters['newest'],
        category: event.filters['category'],
        color: event.filters['color'],
        size: event.filters['size'],
      );

      emit(newState);

      // Make the API call based on the applied filters
      _fetchProductsBasedOnFilters(newState);
    });
  }
}

// Function to fetch products based on the current filter state
void _fetchProductsBasedOnFilters(FilterState filterState) async {
  final filterData = {
    'priceSort': filterState.priceSort,
    'newest': filterState.newest,
    'category': filterState.category,
    'color': filterState.color,
    'size': filterState.size,
  };

  final filteredProducts =
      await FilteredProduct().fetchFilteredProducts(filterData);

  print('filtered prooo $filteredProducts');

  if (filteredProducts.isNotEmpty) {
    // Dispatch an event to NewArrivalsBloc to update its state
    //newArrivalsBloc.add(UpdateNewArrivalsEvent(filteredProducts));
    NewArrivalsBloc(GetAllNewArrivalsApi())
        .add(UpdateNewArrivalsEvent(filteredProducts));
  } else {
    print('No products found');
  }
}
