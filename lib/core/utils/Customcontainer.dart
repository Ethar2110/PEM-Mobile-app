import 'package:flutter/material.dart';

class Customcontainer extends StatelessWidget {
  final String title;
  final String remainingText;
  final double remainingFontSize;
  final Color remainingColor;
  final String progressText;
  final double progressValue;
  final String targetDate;
  final String statusText;

  const Customcontainer({
    super.key,
    required this.title,
    required this.remainingText,
    this.remainingFontSize = 14,
    this.remainingColor = Colors.grey,
    this.progressText = "0 of 0",
    this.progressValue = 0.0,
    this.targetDate = "--/--/----",
    this.statusText = "Unknown",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.grey),
            ],
          ),

          Text(
            remainingText,
            style: TextStyle(
              color: remainingColor,
              fontSize: remainingFontSize,
            ),
          ),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,            children: [
              Text(
                progressText,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                "${(progressValue * 100).toInt()}%",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.white24,
            color: Color(0xFF72E369),
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Target date: $targetDate",
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),

              Row(
                children: [
                  const Text(
                    "Status: ",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}