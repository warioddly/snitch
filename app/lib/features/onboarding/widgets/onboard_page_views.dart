import 'package:flutter/material.dart';


class OnboardPageViews extends StatelessWidget {

  const OnboardPageViews({super.key, required this.children, this.onPageChanged, this.controller, this.physics});


  final List<Widget> children;
  final Function(int index)? onPageChanged;
  final PageController? controller;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: physics,
      controller: controller,
      onPageChanged: onPageChanged,
      children: children
    );
  }


}