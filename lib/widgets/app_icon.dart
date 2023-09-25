import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColorIcon;
  final Color colorIcon;
  final double size;
  final double sizeIcon;

  const AppIcon({
    super.key,
    required this.icon,
    this.backgroundColorIcon = const Color(0xFFfcf4e4),
    this.colorIcon = const Color(0xFF756d54),
    this.size = 24,
    this.sizeIcon = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColorIcon,
      ),
      child: Icon(
        color: colorIcon,
        icon,
        size: sizeIcon,
      ),
    );
  }
}
