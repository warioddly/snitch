import 'package:flutter/material.dart';
import 'package:snitch/shared/ui/images/logo.dart';

class Asset extends StatelessWidget {
  const Asset(this.path, {super.key, this.width, this.height, this.fit});

  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Logo(width: width, height: height);
      }
    );
  }
}
