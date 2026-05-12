import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String optionText;
  final int optionIndex;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color correctColor;
  final Color incorrectColor;

  const OptionCard({
    super.key,
    required this.optionText,
    required this.optionIndex,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    required this.onTap,
    this.selectedColor = const Color(0xFF6C63FF),
    this.correctColor = const Color(0xFF4CAF50),
    this.incorrectColor = const Color(0xFFF44336),
  });

  Color _getBackgroundColor() {
    if (!showResult) {
      return isSelected ? selectedColor : Colors.white;
    }
    if (isCorrect) {
      return correctColor;
    }
    if (isSelected && !isCorrect) {
      return incorrectColor;
    }
    return Colors.white;
  }

  Color _getBorderColor() {
    if (!showResult) {
      return isSelected ? selectedColor : Colors.grey[300]!;
    }
    if (isCorrect) {
      return correctColor;
    }
    if (isSelected && !isCorrect) {
      return incorrectColor;
    }
    return Colors.grey[300]!;
  }

  Color _getTextColor() {
    if (!showResult) {
      return isSelected ? Colors.white : Colors.black;
    }
    if (isCorrect || (isSelected && !isCorrect)) {
      return Colors.white;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showResult ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          border: Border.all(
            color: _getBorderColor(),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getBackgroundColor().withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getBorderColor(),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + optionIndex), // A, B, C, D
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  color: _getTextColor(),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showResult && isCorrect)
              Icon(
                Icons.check_circle,
                color: correctColor,
                size: 24,
              ),
            if (showResult && isSelected && !isCorrect)
              Icon(
                Icons.cancel,
                color: incorrectColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
