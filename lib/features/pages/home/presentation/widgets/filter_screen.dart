import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          TextButton(
            onPressed: () {
              // Clear filter logic
            },
            child: Text(
              'Clear Filters',
              style: TextStyle(color: Colors.blue),
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
        centerTitle: true,
      ),
      body: Drawer(
        width: 340,
        child: Card(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              ExpansionTile(
                title: Text('Price'),
                children: [
                  // Add your price range selector here
                ],
              ),
              ExpansionTile(
                title: Text('Brand'),
                children: [
                  // Add brand options here
                ],
              ),
              ExpansionTile(
                title: Text('Color'),
                children: [
                  // Add color options here
                ],
              ),
              ExpansionTile(
                title: Text('Categories'),
                children: [
                  // Add categories options here
                ],
              ),
              ExpansionTile(
                title: Text('Material'),
                children: [
                  // Add material options here
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Apply filter logic
          },
          child: Text('Apply'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
