import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicturePicker extends StatelessWidget {
  final File? profilePicture;
  final Function(File) onImageSelected;

  const ProfilePicturePicker({
    super.key,
    required this.profilePicture,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          final file = File(pickedFile.path);
          final fileSize = await file.length(); // File size in bytes
          const maxSizeInBytes = 5 * 1024 * 1024; // 5 MB in bytes

          if (fileSize <= maxSizeInBytes) {
            onImageSelected(file);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please select an image smaller than 5 MB.')),
              );
            }
          }
        }
      },
      child: CircleAvatar(
        radius: 40,
        backgroundImage: profilePicture != null
            ? FileImage(profilePicture!)
            : const AssetImage('assets/profile_icon_blank.png'),
      ),
    );
  }
}
