import 'package:dil_hack_e_commerce/api/new_arrivals_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'new_arrivals_event.dart';
import 'new_arrivals_state.dart';

class NewArrivalsBloc extends Bloc<NewArrivalsEvent, NewArrivalsState> {
  final GetAllNewArrivalsApi newArrivalsApi; // Repository to fetch products.

  NewArrivalsBloc(this.newArrivalsApi) : super(NewArrivalsLoading()) {
    on<FetchNewArrivalsEvent>(_onFetchNewArrivals);
  }

  void _onFetchNewArrivals(
    FetchNewArrivalsEvent event,
    Emitter<NewArrivalsState> emit,
  ) async {
    try {
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
}
