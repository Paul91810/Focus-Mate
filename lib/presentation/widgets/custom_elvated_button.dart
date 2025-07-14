import 'package:flutter/material.dart';
import 'package:focus_mate/core/constants/app_colors.dart';

class CustomAppElvatedButton extends StatelessWidget {
  const CustomAppElvatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backGroundcolor,
    this.disabledBackgroundColor,
    this.shape,
    this.buttonSize,
    this.bordersideColor,
  });

  final Widget child;
  final Future<void> Function() onPressed;
  final Color? backGroundcolor;
  final Color? disabledBackgroundColor;
  final OutlinedBorder? shape;
  final Size? buttonSize;
  final Color? bordersideColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: bordersideColor ?? Colors.transparent),
        disabledBackgroundColor: disabledBackgroundColor,
        backgroundColor: backGroundcolor ?? AppColors.kSecondryColor,
        shape: shape,
        minimumSize: buttonSize ?? Size(double.infinity, 48),
      ),
      child:child
       
);
}
}
