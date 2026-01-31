import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String selectedCategory;
  final List<String> categories;
  final ValueChanged<String> onChanged;

  const CustomDropdownFormField({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return DropdownButtonFormField<String>(
      value: selectedCategory,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
        size: screenWidth * 0.05, // responsive icon size
      ),
      iconSize: screenWidth * 0.05,
      dropdownColor: const Color(0xFF101010),
      decoration: InputDecoration(
        labelText: "Category",
        labelStyle: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.015,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
      ),
      style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category, style: TextStyle(fontSize: screenWidth * 0.045)),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
