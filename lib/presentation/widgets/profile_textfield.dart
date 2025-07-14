import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.emailController,
    required this.prefixIcon,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    required this.validatorMessage,
  });

  final TextEditingController emailController;
  final String prefixIcon;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String validatorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        return null;
      },
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIconColor: Colors.black,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            prefixIcon,
            color: Colors.black,
            height: 16,
          ),
        ),
        hintStyle: const TextStyle(color: Colors.black),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
      ),
    );
  }
}
