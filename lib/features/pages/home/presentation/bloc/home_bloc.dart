import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchCategoriesEvent>(_getCategories);
  }

  FutureOr<void> _getCategories(
      FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await dio.get('accessToken');

      log(response.data);
    } catch (e) {
      log(e.toString());
    }
  }
}
