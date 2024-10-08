import 'package:dil_hack_e_commerce/api/addtocart_api.dart';
import 'package:dil_hack_e_commerce/api/new_arrivals_api.dart';
import 'package:dil_hack_e_commerce/api/productByCategory.dart';
import 'package:dil_hack_e_commerce/api/productById_api.dart';
import 'package:dil_hack_e_commerce/api/products_api.dart';
import 'package:dil_hack_e_commerce/api/similar_product_api.dart';
import 'package:dil_hack_e_commerce/api/wishList_api.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/getProductByCategorybloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/FilteredProduct/filter_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/NewArrivals/new_arrivals_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/ProductDetail/product_detail_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Searchbar/search_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/auth_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Products/product_bloc.dart';
//import 'package:dil_hack_e_commerce/features/pages/home/presentation/bloc/home_bloc.dart';
import 'package:dil_hack_e_commerce/features/splash_screen/splash_screen.dart';
//import 'package:dil_hack_e_commerce/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api/category_api.dart';
import 'features/auth/bloc/Categories/category_bloc.dart';
import 'features/auth/bloc/Categories/category_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // await Hive.openBox<Token>('tokenBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // AuthBloc Provider
        BlocProvider(
          create: (context) => AuthBloc(),
        ),

        BlocProvider(
          create: (context) => SearchBloc(),
        ),

        BlocProvider(
          create: (context) => NewArrivalsBloc(GetAllNewArrivalsApi()),
        ),

        BlocProvider(
          create: (context) => ProductBloc(productApi: GetAllProductApi())
            ..add(FetchProductsEvent()),
        ),

        BlocProvider(
            create: (context) =>
                ProductByCategoryBloc(GetProductsByCategory())),

        BlocProvider(
          create: (context) => FilterBloc(),
        ),

        BlocProvider(
          create: (context) => ProductDetailBloc(
            productApi: ProductbyidApi(),
            similarProductsApi: GetSimilarProductsApi(),
          ),
        ),

        BlocProvider(create: (context) => CartBloc(CartService())),
        BlocProvider(
          create: (context) => CategoryBloc(categoryApi: CategoryApi())
            ..add(FetchCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              WishlistBloc(WishlistService())..add(FetchWishlistItems()),
        ),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Palette.backgroundColor),
        home:

            const SplashScreen(),

      ),
    );
  }
}

// 6235749079

// 9846571297 
// 8921633037


