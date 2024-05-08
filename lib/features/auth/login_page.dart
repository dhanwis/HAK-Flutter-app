import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoginImage(height: height, width: width),
            const H50(),
            OtpTextField(width: width),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 60,
              width: width * 0.5,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 195, 144, 148),
                      offset: Offset(-10, 20),
                      blurRadius: 10)
                ],
                borderRadius: BorderRadius.circular(20),
                color: Palette.textFormBorder,
              ),
              child: Center(
                child: Text(
                  'Send OTP',
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const H50(),
            Text('Dilhak.com',style: GoogleFonts.aBeeZee(color:Colors.grey.shade500,fontSize:16),)
          ],
        ),
      ),
    );
  }
}

class LoginImage extends StatelessWidget {
  const LoginImage({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Palette.shadowPink,
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(400),
      ),
      elevation: 10,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(400),
        ),
        child: Image.asset(
          'assets/images/shopping.jpeg',
          height: height * 0.65,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class H50 extends StatelessWidget {
  const H50({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
    );
  }
}

class OtpTextField extends StatefulWidget {
  final double width;

  const OtpTextField({super.key, required this.width});

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.width * 0.7),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.phone,
            color: Colors.grey,
          ),
          hintText: 'Mobile Number',
          enabledBorder:_border(),
          focusedBorder: _border(),
          border: _border(),
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(
        width: 3.0,
        color: Palette.textFormBorder,
      ),
    );
  }
}
