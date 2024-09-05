import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/new_arrivals_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/NewArrivals/new_arrivals_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/NewArrivals/new_arrivals_state.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';

class NewArrivalsBloc extends Bloc<NewArrivalsEvent, NewArrivalsState> {
  final GetAllNewArrivalsApi newArrivalsApi;

  NewArrivalsBloc({required this.newArrivalsApi})
      : super(NewArrivalsLoading()) {
    on<FetchNewArrivalsEvent>((event, emit) async {
      try {
        final List<Product> products = await newArrivalsApi.fetchNewArrivals();
        emit(NewArrivalsLoaded(products));
      } catch (error) {
        emit(NewArrivalsError(error.toString()));
      }
    });
  }
}

//9074434030