import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.iconColor,
      this.backgroundColor});
  final VoidCallback? onPressed;
  final IconData icon;
  final Color iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? Colors.grey.shade200,
        ),
      ),
      icon: Icon(
        icon,
        color: iconColor,
      ),
      onPressed: onPressed,
    );
  }
}
