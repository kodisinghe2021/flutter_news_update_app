import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.lable,
    required this.controller,
    this.is_obsecure = false,
  }) : super(key: key);

  final String lable;
  final bool is_obsecure;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: lable,
        labelStyle: const TextStyle(color: Colors.blueAccent),
        focusColor: Colors.orange,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
      obscureText: is_obsecure,
    );
  }
}
