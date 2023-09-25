import 'package:flutter/cupertino.dart';

import '../utils/colors.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final int? maxLinesText;

  const SmallText(
      {super.key,
      this.color = AppColors.textColor,
      required this.text,
      this.size = 14,
      this.height = 1.2,
      this.maxLinesText});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLinesText,
        style: TextStyle(
            color: color,
            height: height,
            fontSize: size,
            fontWeight: FontWeight.w400));
  }
}
