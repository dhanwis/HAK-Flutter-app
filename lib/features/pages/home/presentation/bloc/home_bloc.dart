import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/models/products_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchCategoriesEvent>(_getCategories);
    on<FetchProductEvent>(_fetchProducts);
  }
  Dio dio = Dio();

  FutureOr<void> _getCategories(
      FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');

    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await dio.get('accessToken');

      log(response.data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future _fetchProducts(
      FetchProductEvent event, Emitter<HomeState> emit) async {
    List<ProductsModel> productList = [];
    const String url = 'https://fakestoreapi.com/products';

    try {
      emit(ProductsLoadingState());
      final response = await dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {

        emit(ProductsFetchedState(productList: productList) );


        for (var i in response.data) {

          productList.add(
            ProductsModel.fromJson(i),
          );
       print(  productList[0].image);

        }

      }
    } catch (error) {
      print(error);
      emit(ProductsFetchingErrorState());

    }


  }
}
