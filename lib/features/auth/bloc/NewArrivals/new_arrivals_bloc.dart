import 'package:dil_hack_e_commerce/api/new_arrivals_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'new_arrivals_event.dart';
import 'new_arrivals_state.dart';

// class NewArrivalsBloc extends Bloc<NewArrivalsEvent, NewArrivalsState> {
//   final GetAllNewArrivalsApi newArrivalsApi; // Repository to fetch products.

//   NewArrivalsBloc(this.newArrivalsApi) : super(NewArrivalsLoading()) {
//     on<FetchNewArrivalsEvent>(_onFetchNewArrivals);
//   }

//   void _onFetchNewArrivals(
//     FetchNewArrivalsEvent event,
//     Emitter<NewArrivalsState> emit,
//   ) async {
//     try {
//       emit(NewArrivalsLoading());
//       final products = await newArrivalsApi.fetchNewArrivals();
//       if (products.isNotEmpty) {
//         emit(NewArrivalsLoaded(products));
//       } else {
//         emit(NewArrivalsError('No products found'));
//       }
//     } catch (error) {
//       print('Error: $error');
//       emit(NewArrivalsError('Failed to load new arrivals: $error'));
//     }
//   }
// }

class NewArrivalsBloc extends Bloc<NewArrivalsEvent, NewArrivalsState> {
  final GetAllNewArrivalsApi newArrivalsApi; // Repository to fetch products.

  NewArrivalsBloc(this.newArrivalsApi) : super(NewArrivalsLoading()) {
    on<FetchNewArrivalsEvent>(_onFetchNewArrivals);
    on<UpdateNewArrivalsEvent>(_onUpdateNewArrivals); // New event handler
  }

  // Fetch new arrivals from the API
  void _onFetchNewArrivals(
    FetchNewArrivalsEvent event,
    Emitter<NewArrivalsState> emit,
  ) async {
    try {
      print('Fetching new arrivals...');
      emit(NewArrivalsLoading());
      final products = await newArrivalsApi.fetchNewArrivals();
      if (products.isNotEmpty) {
        emit(NewArrivalsLoaded(products));
      } else {
        emit(NewArrivalsError('No products found'));
      }
    } catch (error) {
      print('Error: $error');
      emit(NewArrivalsError('Failed to load new arrivals: $error'));
    }
  }

  // Handle updating new arrivals with filtered products
  void _onUpdateNewArrivals(
    UpdateNewArrivalsEvent event,
    Emitter<NewArrivalsState> emit,
  ) {
    if (event.filteredProducts.isNotEmpty) {
      print('correct bro'); // This was printing correctly
      emit(NewArrivalsLoaded(event.filteredProducts));
    } else {
      emit(NewArrivalsError('No filtered products found'));
    }
  }
}
