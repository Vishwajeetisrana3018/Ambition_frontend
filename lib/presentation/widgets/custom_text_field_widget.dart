import 'package:flutter/material.dart';

class CustomeTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final Widget prefixIcon;
  final String emptyMessage;
  final TextInputType keyboardType;
  final bool readOnly;

  const CustomeTextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.label,
      required this.prefixIcon,
      required this.emptyMessage,
      required this.keyboardType,
      required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIconColor: Colors.black,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: prefixIcon,
        ),
        hintStyle: const TextStyle(color: Colors.black),
        hintText: hintText,
        label: Text(label),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyMessage;
        }
        return null;
      },
    );
  }
}
