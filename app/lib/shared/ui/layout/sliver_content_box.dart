import 'package:flutter/material.dart';

class SliverContentBox extends StatelessWidget {

  final Widget child;
  final EdgeInsets padding;

  const SliverContentBox({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: child,
    );
  }

}