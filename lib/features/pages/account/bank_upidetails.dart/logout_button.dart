import 'package:flutter/material.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.logout_outlined, color: Colors.black),
            title: Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: EdgeInsets.all(0),
                    contentPadding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Are you sure you want to logout?'),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: Text('Cancel'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Add logout functionality here
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: Text('Logout'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: LogoutConfirmationDialog()));
}
