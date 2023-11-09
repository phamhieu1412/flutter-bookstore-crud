// ignore_for_file: sized_box_for_whitespace

import 'package:bookstore_crud/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  final double sizeIcon;
  final double heightContent;

  const Loading({super.key, this.sizeIcon = 100, this.heightContent = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightContent,
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppColors.mainColor,
        size: sizeIcon,
      ),
    );
  }
}
