import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/auth_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/model.dart';
import 'package:dil_hack_e_commerce/features/hak_bottom_bar/home_screen.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/bloc/home_bloc.dart';
import 'package:dil_hack_e_commerce/features/splash_screen/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<Token>('tokenBox'); // Open the tokenBox here
  runApp(const MyApp());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc()..add(FetchProductEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Palette.backgroundColor),
        home: SplashScreen(),
      ),
    );
  }
}
