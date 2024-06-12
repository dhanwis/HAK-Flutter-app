import 'package:flutter/material.dart';

class NewArrivelText extends StatelessWidget {
  const NewArrivelText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24, left: 20),
      child: Text(
        "NewArrivals",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
