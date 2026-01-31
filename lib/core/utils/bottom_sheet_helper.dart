import 'package:flutter/material.dart';

import 'Custom_bottom_sheet.dart';

void openCustomSheet({
  required BuildContext context,
  required String title,
  required List<Widget> fields,
  required String actionText,
  required VoidCallback onAction,
}) {
  showModalBottomSheet(
    backgroundColor: const Color(0xFF101010),
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return CustomBottomSheet(
        title: title,
        fields: fields,
        actionText: actionText,
        onAction: onAction,
      );
    },
  );
}
