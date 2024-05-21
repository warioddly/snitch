

import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.width = 200, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: width,
      height: height,
    );
  }
}
