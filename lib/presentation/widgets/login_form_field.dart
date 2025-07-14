import 'package:flutter/material.dart';

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    super.key,
    required this.editingController,
    required this.hintText,
    required this.prefixIconPath,
    required this.validationMessage,
  });

  final TextEditingController editingController;
  final String hintText;
  final String prefixIconPath;
  final String validationMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
      style: const TextStyle(),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            prefixIconPath,
            height: 16,
          ),
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 1.0),
        ),
      ),
    );
  }
}
