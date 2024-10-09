




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/text_style.dart';

class DontHaveAnAccountButton extends StatelessWidget {
  final VoidCallback? onTap;

  const DontHaveAnAccountButton({
    super.key,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyleClass.bonaGrey15,
        ),
        CupertinoButton(
            child: Text(
              "SignUp",
              style: TextStyleClass.bonaPurpleBold15,
            ),
            onPressed: onTap)
      ],
    );
  }
}