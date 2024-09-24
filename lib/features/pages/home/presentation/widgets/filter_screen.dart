import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
          style: GoogleFonts.aBeeZee(fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Clear Filters',
              style: GoogleFonts.aBeeZee(color: Colors.green),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        // centerTitle: true,
      ),
      body: Drawer(
        width: 340,
        child: Card(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              ExpansionTile(
                title: Text(
                  'Price',
                  style: GoogleFonts.aBeeZee(fontSize: 15),
                ),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  'Brand',
                  style: GoogleFonts.aBeeZee(fontSize: 15),
                ),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  'Color',
                  style: GoogleFonts.aBeeZee(fontSize: 15),
                ),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  'Categories',
                  style: GoogleFonts.aBeeZee(fontSize: 15),
                ),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  'Material',
                  style: GoogleFonts.aBeeZee(fontSize: 15),
                ),
                children: [],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            'Apply',
            style: GoogleFonts.aBeeZee(fontSize: 15, color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFAAAB1),
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
