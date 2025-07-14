import 'dart:io';

import 'package:flutter/material.dart';

class ProfileAdditionalImageCard extends StatelessWidget {
  const ProfileAdditionalImageCard({
    super.key,
    required this.picture,
    this.color,
    this.imageUrl,
  });

  final File? picture;
  final Color? color;
  final String? imageUrl;

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
              : (imageUrl != null && imageUrl!.isNotEmpty)
                  ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: picture == null && (imageUrl == null || imageUrl!.isEmpty)
            ? Center(
                child: Image.asset('assets/camera_icon.png',
                    width: 40, height: 40, color: color),
              )
            : null,
      ),
    );
  }
}
