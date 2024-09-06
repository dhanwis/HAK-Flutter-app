import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAAAB1),
        title: Text(
          'ProfilePage',
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    );
  }
}
