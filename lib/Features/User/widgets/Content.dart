import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  final String text;
  final Color color;
  final Color bgColor;
  final VoidCallback callback;

  const Content({
    super.key,
    required this.text,
    required this.color,
    required this.bgColor,
    required this.callback,
  });

  IconData _getIcon(String text) {
    switch (text) {
      case "Complain Box":
        return Icons.report_problem; // Complaint icon
      case "Notification":
        return Icons.notifications; // Notification icon
      case "Weather Updates":
        return Icons.cloud; // Weather icon
      case "Feed Back":
        return Icons.feedback; // Feedback icon
      case "report":
        return Icons.report;
      case "work":
        return Icons.work;
      default:
        return Icons.help_outline; // Default icon
    }

  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: 100,
        height: 150,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIcon(text),
              size: 40,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(fontSize: 15, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
