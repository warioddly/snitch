import 'package:flutter/material.dart';

class BorderedTextField extends StatelessWidget {

  const BorderedTextField({super.key, this.controller, this.decoration});

  final TextEditingController? controller;
  final InputDecoration? decoration;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: decoration,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: const Color(0xFFA3A3A8),
        fontWeight: FontWeight.w400,
      )
    );
  }
}
