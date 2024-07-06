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
        backgroundColor:
            Theme.of(context).iconButtonTheme.style!.backgroundColor,
      ),
      icon: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: onPressed,
    );
  }
}
