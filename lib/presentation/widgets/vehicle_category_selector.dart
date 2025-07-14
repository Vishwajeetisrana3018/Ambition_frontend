import 'package:flutter/material.dart';

class VehicleCategorySelector extends StatelessWidget {
  final String? selectedCategory;
  final Function(String?) onCategoryChanged;

  const VehicleCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            SizedBox(width: 16),
            Text(
              'Select Vehicle Category',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'Car',
              groupValue: selectedCategory,
              onChanged: onCategoryChanged,
            ),
            const Text('Car'),
            Radio<String>(
              value: 'Van',
              groupValue: selectedCategory,
              onChanged: onCategoryChanged,
            ),
            const Text('Van'),
          ],
        ),
      ],
    );
  }
}
