import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: width * 0.7),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                  enabledBorder: _border(),
                  focusedBorder: _border(),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.pink,
            width: width * 0.5,
            height: 30,
          )
        ],
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(
        width: 2.0,
        color: Color.fromARGB(255, 230, 70, 123),
      ),
    );
  }
}
