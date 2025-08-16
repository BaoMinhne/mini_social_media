import 'package:flutter/material.dart';

class MyUserInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const MyUserInput({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 70,
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 1,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black26),
          filled: true,
          // fillColor: Color(0xFFececf8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: Icon(Icons.attach_file),
        ),
      ),
    );
  }
}
