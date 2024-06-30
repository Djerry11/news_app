import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedWelcomeText extends StatefulWidget {
  const AnimatedWelcomeText(
      {super.key,
      required this.text,
      this.textStyle,
      this.speed,
      this.repeatForever});
  final TextStyle? textStyle;
  final String? text;
  final int? speed;
  final bool? repeatForever;

  @override
  State<AnimatedWelcomeText> createState() => _AnimatedWelcomeTextState();
}

class _AnimatedWelcomeTextState extends State<AnimatedWelcomeText> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: widget.repeatForever ?? false,
      animatedTexts: [
        TypewriterAnimatedText(
          widget.text ?? 'Welcome to News App',
          textStyle: widget.textStyle ??
              const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
          speed: Duration(milliseconds: widget.speed ?? 100),
        ),
      ],
      totalRepeatCount: 1,
    );
  }
}
