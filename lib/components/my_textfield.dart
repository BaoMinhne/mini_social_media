import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const MyTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.isEnabled = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hintText,
        suffixIcon: isEnabled
            ? IconButton(
                icon: const Icon(Icons.image),
                onPressed: onPressed,
              )
            : null,
      ),
      obscureText: obscureText,
    );
  }
}
