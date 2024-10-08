




import 'package:flutter/cupertino.dart';

class Click extends StatefulWidget {

  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final Widget child;
  const Click({super.key,  this.onPressed, required this.child, this.padding});

  @override
  State<Click> createState() => _ClickState();
}

class _ClickState extends State<Click> {
  @override
  Widget build(BuildContext context) {

    return  CupertinoButton(
      padding:widget.padding??EdgeInsets.zero,
      onPressed:  widget.onPressed??(){},child: widget.child,);
  }
}

