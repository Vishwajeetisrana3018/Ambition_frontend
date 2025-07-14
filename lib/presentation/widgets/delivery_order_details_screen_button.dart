import 'package:flutter/material.dart';

class OrderDetailsScreenButton extends StatelessWidget {
  const OrderDetailsScreenButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.text,
    this.onPressed,
  });
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          splashFactory: onPressed == null ? NoSplash.splashFactory : null,
          overlayColor: onPressed == null ? Colors.transparent : null,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: borderColor),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
      ),
    );
  }
}
