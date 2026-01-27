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
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: valueSize,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
