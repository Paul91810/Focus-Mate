import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/presentation/productivity_tracker/widgets/focus_hours.dart';
import 'package:focus_mate/presentation/productivity_tracker/widgets/progress.dart';
import 'package:focus_mate/presentation/productivity_tracker/widgets/progress_indicator.dart';
import 'package:focus_mate/presentation/productivity_tracker/widgets/task_completion.dart';

class ProductivityScreen extends StatelessWidget {
   ProductivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          height: 160.h,
          width: double.infinity,

          decoration: BoxDecoration(
            color: AppColors.kButtonBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSize.commonHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Productivity Score',
                    style: TextTheme.of(context).bodyLarge,
                  ),
                  Text('82'),
                ],
              ),
              AppSize.commonHeight,
              Expanded(
                child: LineChart(
                  LineChartData(
                    backgroundColor: AppColors.kButtonBlue,
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(),
                      leftTitles: AxisTitles(),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),

                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.white,
                        barWidth: 5.w,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        spots: [
                          FlSpot(0.39, 1.5),
                          FlSpot(1.10, 2.5),
                          FlSpot(1.8, 2.50),
                          FlSpot(2.60, 3.50),
                          FlSpot(4, 2.80),
                          FlSpot(4.80, 3),
                          FlSpot(5.80, 3.50),
                          FlSpot(6.80, 4.10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSize.commonHeight,
        GridView.builder(
          itemCount: 4,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.90,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.kButtonBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: gridViewIteams[index],
            );
          },
        ),
      ],
    );
  }
  final List<Widget> gridViewIteams = [
    TaskCompletion(),
    FocusHours(),
    Progress(),
    ProgressIndicatorT(),
  ];
}