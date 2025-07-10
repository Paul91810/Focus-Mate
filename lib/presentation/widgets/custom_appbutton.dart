import 'package:flutter/material.dart';
import 'package:focus_mate/core/constants/app_colors.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backGroundcolor=AppColors.kSecondryColor,
    this.shape,
    this.buttonSize,
    this.disabledBackgroundColor,
    this.bordersideColor
   
  });
  final Widget child;
  final Function onPressed;
  final Color? backGroundcolor;
  final Color?disabledBackgroundColor;
  final OutlinedBorder?shape;
  final Size?buttonSize;
  final Color?  bordersideColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(color:bordersideColor??Color(0x00000000)),
        disabledBackgroundColor: disabledBackgroundColor,
        backgroundColor: backGroundcolor,
        shape: shape,
        minimumSize: buttonSize
      ),
      onPressed: () {
        onPressed();
      }, child: child);
  }
}
