import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Progress", style: TextTheme.of(context).bodyLarge),
        AppSize.commonHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Icon(Icons.check_circle, color: AppColors.kWhite, size: 80.w,),
            Text("40%", style: TextTheme.of(context).bodyLarge),
          ],
        ),
      ],
    );
  }
}
