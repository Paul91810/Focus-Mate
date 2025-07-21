import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';

class TaskCompletion extends StatelessWidget {
  const TaskCompletion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          clipBehavior: Clip.none,
          children: [
            Text('Task Completions', style: TextTheme.of(context).bodyLarge),
            Positioned(
              top: 30.w,
              child: Text('75%', style: TextTheme.of(context).bodyLarge),
            ),
          ],
        ),
        AppSize.height20,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
