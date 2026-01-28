import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? searchFocusNode;
  final Color filedColor;
  final Color cursorColor;
  final Color iconColor;
  final Color hintColor;
  final double circularBorderRadius;

  const SearchField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    required this.onChanged,
    this.onSubmitted,
    this.searchFocusNode,
    this.filedColor = Colors.white,
    this.cursorColor = Colors.black,
    this.iconColor = Colors.deepPurpleAccent,
    this.hintColor = Colors.black,
    this.circularBorderRadius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: TextStyle(color: cursorColor),
      validator: validator,
      onChanged: onChanged,
      focusNode: searchFocusNode,
      onFieldSubmitted: onSubmitted,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        hintText: label,
        errorStyle: const TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintStyle: TextStyle(color: hintColor, fontSize: 16),
        prefixIcon: Icon(Icons.search, color: iconColor, size: 25),
        prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 120),
        filled: true,
        fillColor: filedColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
