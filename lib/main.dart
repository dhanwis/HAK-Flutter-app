import 'package:dil_hack_e_commerce/api/products_api.dart';

import 'package:dil_hack_e_commerce/core/theme/palette.dart';

import 'package:dil_hack_e_commerce/features/auth/bloc/Searchbar/search_bloc.dart';

import 'package:dil_hack_e_commerce/features/auth/bloc/auth_bloc.dart';

import 'package:dil_hack_e_commerce/features/auth/bloc/Products/product_bloc.dart';
import 'package:dil_hack_e_commerce/features/hak_bottom_bar/bottom_bar.dart';

//import 'package:dil_hack_e_commerce/features/pages/home/presentation/bloc/home_bloc.dart';

import 'package:dil_hack_e_commerce/features/splash_screen/splash_screen.dart';

//import 'package:dil_hack_e_commerce/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          create: (context) => ProductBloc(productApi: GetAllProductApi())
            ..add(FetchProductsEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Palette.backgroundColor),
        home: SplashScreen(),
        // DilHackBottomNavBar(),

        // You can set other screens like SplashScreen(), LoginPage(), etc.
      ),
    );
  }
}
// 6235749079

// 9846571297 
// 8921633037