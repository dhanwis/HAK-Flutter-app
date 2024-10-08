






import 'package:flutter/cupertino.dart';

import '../const/text_style.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback? onTap;

  const ForgotPassword({
    super.key,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onTap,
        child: const Text(
          "Forgot Password?",
          style: TextStyleClass.bonaPurpleBold15,
        ));
  }
}