import 'package:flutter/material.dart';
import 'customButton.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final String actionText;
  final VoidCallback onAction;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.fields,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenHeight * 0.028, // responsive font
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          ...fields.map((field) => Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.004),
            child: field,
          )),
          SizedBox(height: screenHeight * 0.02),
          CustomButton(
            text: actionText,
            onPressed: onAction,
          ),
        ],
      ),
    );
  }
}
