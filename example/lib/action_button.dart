import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.title,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
        highlightElevation: 0,
        elevation: 0,
        color: color,
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
