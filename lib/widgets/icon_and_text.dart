import 'package:bookstore_crud/widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final Color textColor;

  const IconAndText(
      {super.key,
      required this.icon,
      required this.text,
      required this.textColor,
      this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(
          width: 5,
        ),
        SmallText(text: text, color: textColor)
      ],
    );
  }
}
