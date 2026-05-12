import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final int remainingSeconds;
  final int totalSeconds;
  final Color textColor;
  final Color? warningColor; // Warna ketika waktu kurang

  const TimerWidget({
    super.key,
    required this.remainingSeconds,
    required this.totalSeconds,
    this.textColor = Colors.black,
    this.warningColor,
  });

  Color _getTimerColor() {
    double percentage = remainingSeconds / totalSeconds;
    if (percentage <= 0.2) {
      return warningColor ?? Colors.red;
    } else if (percentage <= 0.5) {
      return warningColor ?? Colors.orange;
    }
    return Colors.red;
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getTimerColor(),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            color: _getTimerColor(),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            _formatTime(remainingSeconds),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _getTimerColor(),
            ),
          ),
        ],
      ),
    );
  }
}
