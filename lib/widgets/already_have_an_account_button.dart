
import 'package:flutter/cupertino.dart';

import '../const/text_style.dart';

class AlreadyHaveAnAccountButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AlreadyHaveAnAccountButton({
    super.key,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyleClass.bonaGrey15,
        ),
        CupertinoButton(
            child: Text(
              "Login",
              style: TextStyleClass.bonaPurpleBold15,
            ),
            onPressed: onTap)
      ],
    );
  }
}


