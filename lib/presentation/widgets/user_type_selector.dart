import 'package:flutter/material.dart';

class UserTypeSelector extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onSelected;

  const UserTypeSelector({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevation: WidgetStateProperty.all(4),
      ),
      initialSelection: selectedItem,
      onSelected: onSelected,
      dropdownMenuEntries: items.map((String item) {
        return DropdownMenuEntry<String>(
          value: item,
          label: item,
        );
      }).toList(),
    );
  }
}
