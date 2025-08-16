import 'package:flutter/material.dart';

class MyUserInput extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final VoidCallback? onAttachPressed;

  const MyUserInput({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.onAttachPressed,
  });

  @override
  State<MyUserInput> createState() => _MyUserInputState();
}

class _MyUserInputState extends State<MyUserInput> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 70,
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 1,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black26),
          filled: true,
          // fillColor: Color(0xFFececf8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: IconButton(
            icon: const Icon(Icons.image),
            onPressed: widget.onAttachPressed, // 📎 callback khi bấm
          ),
        ),
      ),
    );
  }
}
