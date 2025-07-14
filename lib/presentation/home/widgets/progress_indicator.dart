import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressIndicatorT extends StatelessWidget {
  const ProgressIndicatorT({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progress',style: TextTheme.of(context).bodyLarge,),
        AppSize.commonHeight,
      
        Center(
          child: CircularPercentIndicator(
            radius: 45.w,
            lineWidth: 8.0,
            percent: 0.6, 
            center: Text("60%"),
            progressColor: Colors.blue,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}