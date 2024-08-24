import 'package:dil_hack_e_commerce/api/category_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryApi categoryApi;

  CategoryBloc({required this.categoryApi}) : super(CategoriesInitial()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
  }

  Future<void> _onFetchCategories(
      FetchCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoriesLoading());
    try {
      final categories = await categoryApi.fetchCategories();

      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CategoriesError(error: e.toString()));
    }
  }
}
