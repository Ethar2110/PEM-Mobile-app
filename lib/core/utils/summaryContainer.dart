import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final double height;
  final double borderRadius;
  final Color backgroundColor;

  final String title;
  final String value;

  final Color titleColor;
  final double titleSize;

  final Color valueColor;
  final double valueSize;

  const SummaryCard({
    super.key,
    this.height = 150,
    this.borderRadius = 20,
    this.backgroundColor = const Color(0xFF72E369),

    required this.title,
    required this.value,

    this.titleColor = Colors.white,
    this.titleSize = 20,

    this.valueColor = Colors.black,
    this.valueSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isLargeScreen = screenWidth > 400;

    final cardHeight = height * (screenWidth / 375).clamp(0.85, 1.2);

    final currentTitleSize = isLargeScreen ? titleSize + 2 : titleSize;
    final currentValueSize = isLargeScreen ? valueSize + 2 : valueSize;

    return Container(
      height: cardHeight,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title text
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: currentTitleSize,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            ),
            const SizedBox(height: 6),
            // Value text
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: currentValueSize,
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
