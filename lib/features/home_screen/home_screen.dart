import 'package:dil_hack_e_commerce/features/auth/view_model/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<LoginProvider>(context);
    return  Scaffold(
      body: Center(
        child: Text(pro.accessToken),
      ),
    );
  }
}
