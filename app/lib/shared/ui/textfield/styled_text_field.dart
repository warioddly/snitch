import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StyledTextField extends StatelessWidget {

  const StyledTextField({super.key, this.controller, this.decoration, this.inputFormatters = const [], this.keyboardType});

  final TextEditingController? controller;
  final InputDecoration? decoration;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: decoration?.copyWith(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE5E5EA),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(13)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF505050),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(13)
        ),
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: const Color(0xFFA3A3A8),
          fontWeight: FontWeight.w400,
        ),
      ),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: const Color(0xFFA3A3A8),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
