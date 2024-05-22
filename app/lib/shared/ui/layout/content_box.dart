import 'package:flutter/material.dart';

class ContentBox extends StatelessWidget {

  final Widget child;
  final EdgeInsets padding;

  const ContentBox({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }

}