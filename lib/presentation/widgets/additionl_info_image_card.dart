import 'dart:io';

import 'package:flutter/material.dart';

class AdditionalInfoImageCard extends StatelessWidget {
  const AdditionalInfoImageCard({
    super.key,
    required this.picture,
    this.color,
  });

  final File? picture;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color ?? Colors.white),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color ?? Colors.white),
          ),
          0),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: picture != null
              ? DecorationImage(
                  image: FileImage(picture!),
                  fit: BoxFit.cover,
                )
              : null,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: picture == null
            ? Center(
                child: Image.asset('assets/camera_icon.png',
                    width: 40, height: 40, color: color),
              )
            : null,
      ),
    );
  }
}
