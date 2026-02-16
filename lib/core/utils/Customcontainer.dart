import 'package:flutter/material.dart';

class Customcontainer extends StatelessWidget {
  final String title;
  final String remainingText;
  final String? price;

  final double remainingFontSize;
  final Color remainingColor;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  // Optional parts
  final String? progressText;
  final double? progressValue;
  final String? targetDate;
  final String? statusText;

  const Customcontainer({
    super.key,
    required this.title,
    required this.remainingText,
    this.price,
    this.remainingFontSize = 14,
    this.remainingColor = Colors.grey,
    this.progressText,
    this.progressValue,
    this.targetDate,
    this.statusText,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Align(
                alignment: AlignmentGeometry.topRight,
                child: PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: const Color(0xFF101010),
                  icon: const Icon(Icons.more_vert, color: Colors.grey, size: 23),
                  onSelected: (value) {
                    if (value == 'edit') {
                      if (onEdit != null) onEdit!();
                    } else if (value == 'delete') {
                      if (onDelete != null) onDelete!();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit', style: TextStyle(color: Colors.white)),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),


          Row(
            children: [
              Expanded(
                child: Text(
                  remainingText,
                  style: TextStyle(
                    color: remainingColor,
                    fontSize: remainingFontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (price != null && price!.isNotEmpty)
                Text(
                  "${price!} EG",
                  style: const TextStyle(
                    color: Color(0xFF72E369),
                    fontSize: 16,
                  ),
                ),
            ],
          ),



          if (progressText != null && progressValue != null) ...[
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  progressText!,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  "${(progressValue! * 100).toInt()}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              value: progressValue!,
              backgroundColor: Colors.white24,
              color: const Color(0xFF72E369),
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
            ),
          ],

          if (targetDate != null && statusText != null) ...[
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
                      statusText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}