import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const SearchField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(color: Colors.black),
      validator: validator,
      onChanged: onChanged,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        isDense: true, // Reduces the overall height by using less space
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        hintText: label,
        errorStyle: const TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
        prefixIcon: Icon(Icons.search, color: Colors.deepPurpleAccent, size: 25),
        prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 120),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      ),
    );
  }
}
