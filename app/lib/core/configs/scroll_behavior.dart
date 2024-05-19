import 'package:flutter/material.dart';

class MyScrollBehavior extends ScrollBehavior {

  const MyScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();

}