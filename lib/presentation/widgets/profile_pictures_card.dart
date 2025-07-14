import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePicturesCard extends StatelessWidget {
  const ProfilePicturesCard(
      {super.key,
      required this.picture,
      required this.onTap,
      required this.pictureUrl});
  final File? picture;
  final String? pictureUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.black),
            ),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.black),
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
                : pictureUrl != null
                    ? DecorationImage(
                        image: NetworkImage(pictureUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: picture == null && pictureUrl == null
              ? Center(
                  child: Image.asset(
                    'assets/camera_icon.png',
                    width: 40,
                    height: 40,
                    color: Colors.black,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
