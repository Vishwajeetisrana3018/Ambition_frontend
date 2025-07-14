import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'additionl_info_image_card.dart';

class ImageUploadSection extends StatelessWidget {
  final String title;
  final File? image;
  final Function(File) onImageSelected;

  const ImageUploadSection({
    super.key,
    required this.title,
    required this.image,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? pickedImage =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              final File imageFile = File(pickedImage.path);
              final int imageSize = await imageFile.length();
              const int maxSizeInBytes = 5 * 1024 * 1024; // 5 MB

              if (imageSize <= maxSizeInBytes) {
                onImageSelected(imageFile);
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('The selected image must be less than 5 MB.'),
                    ),
                  );
                }
              }
            }
          },
          child: AdditionalInfoImageCard(
            color: Colors.black,
            picture: image,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
