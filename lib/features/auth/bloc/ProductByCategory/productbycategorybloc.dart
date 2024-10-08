// import 'package:dil_hack_e_commerce/api/productByCategory.dart';
// import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategory_event.dart';
// import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategorystate.dart';
// import 'package:dil_hack_e_commerce/features/auth/bloc/ProductByCategory/productbycategoryevent.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductByCategoryBloc
//     extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
//   final GetProductsByCategory
//       productsByCategoryApi; // Assume you have a repository

//   ProductByCategoryBloc(this.productsByCategoryApi)
//       : super(ProductByCategoryInitial()) {
//     // Use the on<Event> method to handle specific events
//     on<FetchProductsByCategory>(_onFetchProductsByCategory);
//   }

//   // Define the event handler method
//   Future<void> _onFetchProductsByCategory(FetchProductsByCategory event,
//       Emitter<ProductByCategoryState> emit) async {
//     emit(ProductByCategoryLoading());
//     try {
//       final products =
//           await productRepository.fetchProductsByCategory(event.categoryId);
//       emit(ProductByCategoryLoaded(products));
//     } catch (e) {
//       emit(ProductByCategoryError('Failed to fetch products'));
//     }
//   }
// }
