import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {

  const StyledTextField({super.key, this.controller, this.decoration});

  final TextEditingController? controller;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
        decoration: decoration,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: const Color(0xFFA3A3A8),
          fontWeight: FontWeight.w400,
        )
    );
  }
}
